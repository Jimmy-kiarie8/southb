<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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

// Route::middleware('auth:api')->get('/sale', function (Request $request) {
//     return $request->user();
// });


// Route::group(['middleware' => ['auth:sanctum']], function () {

    Route::resource('sales', 'SaleApiController');

    Route::post('cart', 'SaleApiController@cart');
// });
