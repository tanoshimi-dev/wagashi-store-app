<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('store_stamps', function (Blueprint $table) {
            $table->id()->comment('ID');
            $table->string('qr_code')->unique()->comment('QRコード');
            $table->tinyInteger('active_flag')->default(0)->comment('有効フラグ');
            $table->string('memo', 100)->nullable()->comment('メモ');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('store_stamps');
    }
};
