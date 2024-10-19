<?php

namespace App\Services;

use App\Http\Controllers\SaleController;
use App\Models\Mpesa;
use App\Models\Payment;
use App\Models\Transaction;
use DefStudio\Telegraph\Models\TelegraphChat;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SalePayment;

class PaymentService
{
    protected $baseUrl;

    public function __construct()
    {
        $this->baseUrl = 'https://sandbox.safaricom.co.ke';
    }


    public function authorizationToken()
    {
        return env('MPESA_TOKEN');
        try {

            // $shortcode = env('MPESA_SHORT_CODE');
            // $passkey = env('MPESA_PASS_KEY');
            // $timestamp = date('YmdHis', strtotime('now'));


            $secret = env('MPESA_API_SECRET');
            $key = env('MPESA_API_KEY');

            $response = Http::withHeaders([
                'Authorization' => 'Basic ' . $this->base64($key . ':' . $secret),
            ])->get($this->baseUrl . '/oauth/v2/generate?grant_type=client_credentials');

            Log::alert($response);


            return json_decode($response->getBody()->getContents())->access_token;
        } catch (\Throwable $th) {
            throw $th;
        }
    }

    public function url_register()
    {

        try {
            $token = $this->authorizationToken();

            // if (!$mpesa) {
            //     abort(422, 'M-pesa data not available');
            // }

            $shortcode = env('MPESA_SHORT_CODE');

            $response = Http::withHeaders([
                'Content-Type' => 'application/json',
                'Authorization' => 'Bearer ' . $token
            ])
                ->post($this->baseUrl . '/mpesa/c2b/v2/registerurl', [
                    "ShortCode" => $shortcode,
                    "ResponseType" => "Completed",
                    "ConfirmationURL" => env('APP_URL') . "/api/confirmation",
                    "ValidationURL" => env('APP_URL') . "/api/validation",
                ]);

            Log::debug($response);

            echo $response;

            return $response;
            // $mpesa->registered = true;
            // $mpesa->save();
        } catch (\Throwable $th) {
            throw $th;
        }
    }

    public function validation_url()
    {
        return true;
    }

    public function base64($string)
    {
        $encodedString = base64_encode($string);
        return $encodedString;
    }


    public function clean($phone)
    {
        $string = str_replace(' ', '', $phone);
        $string = preg_replace('/[^A-Za-z0-9\-]/', '', $string); // Removes special chars.
        $p_length = strlen($string);
        $str = (int)mb_substr($string, 0, 1);

        if ($p_length == 9 && $str == 7) {
            $phone_no = '254' . $string;
        } elseif ($p_length == 10 && $str == 0) {
            $str = substr($string, 1);
            $phone_no = '254' . $str;
        } else {
            $phone_no = $string;
        }

        return $phone_no;
    }

    public function stk_response(Request $request, $id)
    {

        $resultBody = json_decode($request->getContent());
        $data  = $resultBody->Body->stkCallback->CallbackMetadata->Item;

        $amount = $data[0]->Value;
        $MpesaReceiptNumber = $data[1]->Value;
        $this->order_paid($id, $amount, $MpesaReceiptNumber);

        return;
    }

    public function stk_push($phone, $sale)
    {
        try {
            //code...

            // return $sale;
            $amount = 1;
            // $amount = (int) preg_replace("/[^0-9.]/", "", $sale->total_amount);
            $api_url =  $this->baseUrl . '/mpesa/stkpush/v1/processrequest';
            $shortcode = env('MPESA_SHORT_CODE');
            $passkey = env('MPESA_PASS_KEY');
            $timestamp = date('YmdHis', strtotime('now'));
            $phone = $this->clean($phone);
            $password = $this->base64($shortcode . $passkey . $timestamp);
            $app_url = env('APP_URL') . '/api/stk_response/' . $sale->id;

            // $app_url = 'https://uwxuoesevp.sharedwithexpose.com' . '/api/stk_response/' . $sale->id;

            $token = $this->authorizationToken();

            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . env('MPESA_TOKEN'),
                'Content-Type' => 'application/json',
            ])->post($api_url, [
                "BusinessShortCode" => $shortcode,
                "Password" => $password,
                "Timestamp" => $timestamp,
                "TransactionType" => "CustomerPayBillOnline",
                "Amount" => $amount,
                "PartyA" => $phone,
                "PartyB" => $shortcode,
                "PhoneNumber" => $phone,
                "CallBackURL" => $app_url,
                "AccountReference" => $sale->reference,
                "TransactionDesc" => "Order payment"
            ]);

            return 'Pushed';

            echo $response->body();
        } catch (\Throwable $th) {
            throw $th;
        }
    }


    public function store_transaction($response)
    {
        $transaction = new Transaction();

        $transaction->TransactionType = (array_key_exists('TransactionType', $response)) ? $response['TransactionType'] : null;
        $transaction->TransID = (array_key_exists('TransID', $response)) ? $response['TransID'] : null;
        $transaction->TransTime = (array_key_exists('TransTime', $response)) ? $response['TransTime'] : null;
        $transaction->TransAmount = (array_key_exists('TransAmount', $response)) ? $response['TransAmount'] : null;
        $transaction->BusinessShortCode = (array_key_exists('BusinessShortCode', $response)) ? $response['BusinessShortCode'] : null;
        $transaction->InvoiceNumber = (array_key_exists('InvoiceNumber', $response)) ? $response['InvoiceNumber'] : null;
        $transaction->OrgAccountBalance = (array_key_exists('OrgAccountBalance', $response)) ? $response['OrgAccountBalance'] : null;
        $transaction->ThirdPartyTransID = (array_key_exists('ThirdPartyTransID', $response)) ? $response['ThirdPartyTransID'] : null;
        $transaction->MSISDN = (array_key_exists('MSISDN', $response)) ? $response['MSISDN'] : null;
        $transaction->FirstName = (array_key_exists('FirstName', $response)) ? $response['FirstName'] : null;
        $transaction->MiddleName = (array_key_exists('MiddleName', $response)) ? $response['MiddleName'] : null;
        $transaction->LastName = (array_key_exists('LastName', $response)) ? $response['LastName'] : null;
        $transaction->BillRefNumber = (array_key_exists('BillRefNumber', $response)) ? $response['BillRefNumber'] : null;
        $transaction->save();

        $this->order_paid($transaction->BillRefNumber, $transaction->TransAmount, $transaction->TransID);
    }

    public function order_paid($id, $amount, $mpesa_code)
    {
        $sale = Sale::find($id);
        if (!$sale) {
            return;
        }

        if ($sale) {
            DB::beginTransaction();

            try {

                // $transaction = Transaction::where('TransID', $mpesa_code)->first();

                // if ($transaction) {
                //     $transaction->code_used = true;
                //     $transaction->save();
                // }

                SalePayment::create([
                    'date' => now(),
                    'reference' => 'INV/' . $sale->reference,
                    'amount' => $amount,
                    'sale_id' => $id,
                    'customer_code' => $sale->customer->code,
                    'payment_method' => 'Mpesa'
                ]);

                DB::commit();
            } catch (\Throwable $th) {
                DB::rollBack();
                throw $th;
            }
        }
        return;
    }
}
