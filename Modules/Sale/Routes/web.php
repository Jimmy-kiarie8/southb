<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Route;
use Milon\Barcode\DNS1D;

Route::group(['middleware' => 'auth'], function () {

    //POS
    Route::get('/app/pos', 'PosController@index')->name('app.pos.index');
    Route::post('/app/pos', 'PosController@store')->name('app.pos.store');


    Route::get('/app/payment/{id}', 'PosController@payment')->name('app.pos.payment');
    Route::post('/app/payment/{id}', 'PosController@payment_check')->name('app.pos.payment-check');
    Route::post('/stk_push/{id}', 'PosController@stk_push')->name('app.pos.stk_push');

    //Generate PDF
    Route::get('/sales/pdf/{id}', function ($id) {
        $sale = \Modules\Sale\Entities\Sale::find($id);

        if (!$sale) {
            $sale = \Modules\Sale\Entities\Sale::with('saleDetails')->where('reference', $id)->firstOrFail();
        }
        // $customer = \Modules\People\Entities\Customer::findOrFail($sale->customer_id);
        $customer = \Modules\People\Entities\Customer::find($sale->customer_id);

        if (!$customer) {
            $customer = \Modules\People\Entities\Customer::where('customer_name', $sale->customer_name)->first();
        }
        // use Barryvdh\DomPDF\Facade\Pdf;

        $pdf = Pdf::loadView('sale::print', [
            'sale' => $sale,
            'customer' => $customer,
        ])->setPaper('a4');

        return $pdf->stream('sale-' . $sale->reference . '.pdf');
    })->name('sales.pdf');

    //Generate PDF
    Route::get('/sales/delivery/{id}', function ($id) {
        $sale = \Modules\Sale\Entities\Sale::find($id);

        if (!$sale) {
            $sale = \Modules\Sale\Entities\Sale::with('saleDetails')->where('reference', $id)->firstOrFail();
        }
        // $customer = \Modules\People\Entities\Customer::findOrFail($sale->customer_id);
        $customer = \Modules\People\Entities\Customer::find($sale->customer_id);

        if (!$customer) {
            $customer = \Modules\People\Entities\Customer::where('customer_name', $sale->customer_name)->first();
        }
        // use Barryvdh\DomPDF\Facade\Pdf;

        $pdf = Pdf::loadView('sale::delivery', [
            'sale' => $sale,
            'customer' => $customer,
        ])->setPaper('a4');

        return $pdf->stream('sale-' . $sale->reference . '.pdf');
    })->name('sales.delivery');

    Route::get('/sales/pos/pdf/{id}', function ($id) {
        $sale = \Modules\Sale\Entities\Sale::with(['saleDetails', 'salePayments'])->find($id);


        if (!$sale) {
            $sale = \Modules\Sale\Entities\Sale::with(['saleDetails', 'salePayments'])->find($id)->firstOrFail();
            // $sale = \Modules\Sale\Entities\Sale::with('saleDetails')->where('reference', $id)->firstOrFail();
        }

        $sale->barcode = 'data:image/png;base64,' . DNS1D::getBarcodePNG($sale->reference, "C39");

        $pdf = Pdf::loadView('sale::print-pos', [
            // $pdf = Pdf::loadView('sale::print-pos', [
            'sale' => $sale,
        ])->setPaper('a7')
            ->setOption('margin-top', 0)
            ->setOption('margin-bottom', 0)
            ->setOption('margin-left', 0)
            ->setOption('margin-right', 0);

        return $pdf->stream('sale-' . $sale->reference . '.pdf');
    })->name('sales.pos.pdf');

    //Sales
    Route::resource('sales', 'SaleController');
    Route::resource('close', 'CloseDayController');

    //Payments
    Route::get('/sale-payments/{sale_id}', 'SalePaymentsController@index')->name('sale-payments.index');
    Route::get('/sale-payments/{sale_id}/create', 'SalePaymentsController@create')->name('sale-payments.create');
    Route::post('/sale-payments/store', 'SalePaymentsController@store')->name('sale-payments.store');
    Route::get('/sale-payments/{sale_id}/edit/{salePayment}', 'SalePaymentsController@edit')->name('sale-payments.edit');
    Route::patch('/sale-payments/update/{salePayment}', 'SalePaymentsController@update')->name('sale-payments.update');
    Route::delete('/sale-payments/destroy/{salePayment}', 'SalePaymentsController@destroy')->name('sale-payments.destroy');

    Route::post('/sale-bulk-payment', 'SalePaymentsController@sale_bulk')->name('sale-payments.sale-bulk');


    Route::get('/bulk-payments', 'SalePaymentsController@bulkIndex')->name('sale-payments.bulkIndex');
    Route::get('/bulk-payments/{id}', 'SalePaymentsController@bulkShow')->name('sale-payments.bulkShow');

    Route::delete('/reversePayment/{id}', 'SalePaymentsController@reversePayment')->name('sale-payments.reversePayment');
});
