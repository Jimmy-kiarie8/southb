<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSalesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sales', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->string('reference');
            $table->string('grn_no')->nullable();
            $table->unsignedBigInteger('customer_id')->nullable();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedBigInteger('branch_id')->nullable();
            $table->string('customer_name');
            $table->integer('tax_percentage')->default(0);
            $table->integer('tax_amount')->default(0);
            $table->integer('discount_percentage')->default(0);
            $table->integer('discount_amount')->default(0);
            $table->integer('shipping_amount')->default(0);
            $table->integer('total_amount');
            $table->integer('paid_amount');
            $table->integer('due_amount');
            $table->integer('cu_inv_no')->nullable();
            $table->integer('change_amount')->default(0);
            $table->string('status');
            $table->string('payment_status');
            $table->string('payment_method');
            $table->text('note')->nullable();
            $table->foreign('customer_id')->references('id')->on('customers')->nullOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
            $table->foreign('branch_id')->references('id')->on('branches')->nullOnDelete();
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
        Schema::dropIfExists('sales');
    }
}
