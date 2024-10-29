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

use Modules\GoodIssue\Entities\GoodIssue;

Route::prefix('goodissue')->group(function() {
    Route::get('/', 'GoodIssueController@index')->name('goodissue.index');
    Route::get('/create', 'GoodIssueController@create')->name('goodissue.create');
    Route::post('/', 'GoodIssueController@store')->name('goodissue.store');
    // Route::resource('/', 'GoodIssueController')->name("goodissue");



    //Generate PDF
    Route::get('/sales/pdf/{id}', function ($id) {
        $sale = GoodIssue::find($id);

        if (!$sale) {
            $sale = GoodIssue::with('saleDetails')->where('reference', $id)->firstOrFail();
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
    })->name('goodissue.pdf');

});
