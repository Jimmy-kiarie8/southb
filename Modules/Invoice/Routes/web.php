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

// Route::prefix('invoice')->group(function() {
//     Route::get('/', 'InvoiceController@index');
// });

use Illuminate\Support\Facades\Route;

Route::group(['middleware' => 'auth'], function () {
    // Invoice
    Route::resource('invoice', 'InvoiceController');
    Route::resource('invoice-payment', 'PaymentController');

    Route::get('/invoice-payments/{invoice_id}/create', 'PaymentController@create')->name('invoice-payments.create');

});

