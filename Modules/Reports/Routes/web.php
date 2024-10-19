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
use Modules\Sale\Http\Controllers\SalePaymentsController;

Route::group(['middleware' => 'auth'], function () {
    //Profit Loss Report
    Route::get('/profit-loss-report', 'ReportsController@profitLossReport')
        ->name('profit-loss-report.index');
    //Payments Report
    Route::get('/payments-report', 'ReportsController@paymentsReport')
        ->name('payments-report.index');
    //Sales Report
    Route::get('/sales-report', 'ReportsController@salesReport')
        ->name('sales-report.index');
    //Purchases Report
    Route::get('/purchases-report', 'ReportsController@purchasesReport')
        ->name('purchases-report.index');
    //Sales Return Report
    Route::get('/sales-return-report', 'ReportsController@salesReturnReport')
        ->name('sales-return-report.index');
    //Purchases Return Report
    Route::get('/purchases-return-report', 'ReportsController@purchasesReturnReport')
        ->name('purchases-return-report.index');


    //Supplier Report
    Route::get('/supplier-report', 'ReportsController@supplierReport')
    ->name('supplier-report.index');


    //Customer Report
    Route::get('/customer-report', 'ReportsController@customerReport')
    ->name('customer-report.index');

    // Adjustment Report
    Route::get('/adjustment-report', 'ReportsController@adjustmentReport')
    ->name('adjustment-report.index');


    //Sales Report
    Route::get('/stock-report', 'ReportsController@stockLevel')
        ->name('stock-report.index');

    //Sales Report
    Route::get('/daily-report', 'ReportsController@dailyReport')
    ->name('daily-report.index');

    //Sales Report
    Route::get('/product-report', 'ReportsController@productReport')
    ->name('product-report.index');

    Route::prefix('reports')->group(function() {
        Route::post('/payment', [SalePaymentsController::class, 'payment'])->name('reports.payment');
    });
});
