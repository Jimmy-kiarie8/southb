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

Route::prefix('goodissue')->group(function() {
    Route::get('/', 'GoodIssueController@index')->name('goodissue.index');
    Route::get('/create', 'GoodIssueController@create')->name('goodissue.create');
    Route::post('/', 'GoodIssueController@store')->name('goodissue.store');
    // Route::resource('/', 'GoodIssueController')->name("goodissue");
});
