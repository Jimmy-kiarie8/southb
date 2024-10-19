<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateStocksheetsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('stocksheets', function (Blueprint $table) {
            $table->id();
            $table->string('reference');
            $table->integer('product_id');
            $table->integer('system_qty');
            $table->integer('actual_qty');

            $table->drafts();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('stocksheets');
    }
}
