<?php

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

// Route::get('/products', function (Request $request) {
//     // return $request->user();
//     return Product::all();
// });


// Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::resource('products', 'ProductApiController');
    Route::get('scan/{code}', 'ProductApiController@scan');
    Route::get('search/{search}', 'ProductApiController@search');
    Route::get('categories', 'ProductApiController@categories');
// });
