<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('category_id');
            $table->string('product_name');
            $table->string('product_code')->unique()->nullable();
            $table->string('product_barcode_symbology')->nullable();
            $table->integer('product_quantity')->nullable();
            $table->integer('product_cost')->nullable();
            $table->integer('product_price')->nullable();
            $table->integer('moq')->nullable();
            $table->integer('wholesale_price')->nullable();
            $table->string('product_unit')->nullable();
            $table->integer('product_stock_alert')->nullable();
            $table->integer('product_order_tax')->nullable();
            $table->integer('factor')->default(1);
            $table->tinyInteger('product_tax_type')->nullable();
            $table->text('product_note')->nullable();
            $table->unsignedBigInteger('supplier_id');
            $table->foreign('category_id')->references('id')->on('categories')->restrictOnDelete();

            $table->softDeletes();
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
        Schema::dropIfExists('products');
    }
}
