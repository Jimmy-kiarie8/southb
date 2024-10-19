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

Route::group(['middleware' => 'auth'], function () {

    Route::prefix('stocksheet')->group(function () {
        Route::get('/', 'StocksheetController@index')->name('stocksheet.index');
        Route::post('/getStocksheet', 'StocksheetController@getStocksheet')->name('stocksheet.sheet');
        Route::post('/stocklevel', 'StocksheetController@stocklevel')->name('stocksheet.level');;
        Route::get('/filter', 'StocksheetController@filter')->name('stocksheet.filter');

    });

    Route::resource('stocksheet', 'StocksheetController');


});
