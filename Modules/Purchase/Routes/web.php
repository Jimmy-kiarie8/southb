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

use Illuminate\Support\Facades\Route;
use Barryvdh\DomPDF\Facade\Pdf;

Route::group(['middleware' => 'auth'], function () {

    //Generate PDF
    Route::get('/purchases/pdf/{id}', function ($id) {
        $purchase = \Modules\Purchase\Entities\Purchase::find($id);
        $supplier = \Modules\People\Entities\Supplier::find($purchase->supplier_id);

        $pdf = Pdf::loadView('purchase::print', [
            'purchase' => $purchase,
            'supplier' => $supplier,
        ])->setPaper('a4');

        return $pdf->stream('purchase-'. $purchase->reference .'.pdf');
    })->name('purchases.pdf');

    //Sales
    Route::resource('purchases', 'PurchaseController');

    //Payments
    Route::get('/purchase-payments/{purchase_id}', 'PurchasePaymentsController@index')->name('purchase-payments.index');
    Route::get('/purchase-payments/{purchase_id}/create', 'PurchasePaymentsController@create')->name('purchase-payments.create');
    Route::post('/purchase-payments/store', 'PurchasePaymentsController@store')->name('purchase-payments.store');
    Route::get('/purchase-payments/{purchase_id}/edit/{purchasePayment}', 'PurchasePaymentsController@edit')->name('purchase-payments.edit');
    Route::patch('/purchase-payments/update/{purchasePayment}', 'PurchasePaymentsController@update')->name('purchase-payments.update');
    Route::delete('/purchase-payments/destroy/{purchasePayment}', 'PurchasePaymentsController@destroy')->name('purchase-payments.destroy');

    Route::post('/purchase-bulk-payment', 'PurchasePaymentsController@purchase_bulk')->name('sale-payments.purchase-bulk');




    Route::get('/bulk-purchase-payment', 'PurchasePaymentsController@bulkIndex')->name('purchase-payments.bulkIndex');
    Route::get('/bulk-purchase-payment/{id}', 'PurchasePaymentsController@bulkShow')->name('purchase-payments.bulkShow');

    Route::delete('/reverse-payment/{id}', 'PurchasePaymentsController@reversePayment')->name('purchase-payments.reversePayment');

});
