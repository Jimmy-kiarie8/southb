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

// Route::prefix('transfer')->group(function() {
//     Route::resource('/', 'TransferController');
// });


Route::resource('transfer', 'TransferController');

// Route::post('/transfer_save', 'TransferController@store')->name('transfer_save');
