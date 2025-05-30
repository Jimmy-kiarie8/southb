<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Modules\Stocksheet\Http\Controllers\StocksheetController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/stocksheet', function (Request $request) {
    return $request->user();
});


Route::resource('stocksheet', 'StocksheetController');

Route::post('publish/{id}', [StocksheetController::class, 'publish']);
