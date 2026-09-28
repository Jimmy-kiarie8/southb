<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('sales', function (Blueprint $table) {
            $table->string('clientcode_before_fix', 191)->nullable()->after('clientcode');
            $table->timestamp('code_fixed_at')->nullable()->after('clientcode_before_fix');
        });

        Schema::table('sale_payments', function (Blueprint $table) {
            $table->string('customer_code_before_fix', 191)->nullable()->after('customer_code');
            $table->timestamp('code_fixed_at')->nullable()->after('customer_code_before_fix');
        });
    }

    public function down()
    {
        Schema::table('sales', function (Blueprint $table) {
            $table->dropColumn(['clientcode_before_fix', 'code_fixed_at']);
        });

        Schema::table('sale_payments', function (Blueprint $table) {
            $table->dropColumn(['customer_code_before_fix', 'code_fixed_at']);
        });
    }
};
