<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('close_days', function (Blueprint $table) {
            $table->id();
            $table->string('reference')->nullable();
            $table->integer('user_id')->nullable();
            $table->integer('cb1')->default(0);
            $table->integer('cb2')->default(0);
            $table->integer('kcb')->default(0);
            $table->integer('equity')->default(0);
            $table->integer('cash')->default(0);
            $table->integer('credit_paid')->default(0);
            $table->integer('credit')->default(0);
            $table->integer('cheque')->default(0);
            $table->integer('total')->default(0);
            $table->date('date');
            $table->integer('total_sales')->default(0);
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
        Schema::dropIfExists('close_days');
    }
};
