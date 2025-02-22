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
        Schema::create('user_store_stamps', function (Blueprint $table) {
            $table->id()->comment('ID');
            $table->integer('user_id')->comment('ユーザーID');
            $table->integer('stamp_id')->comment('来店スタンプID');
            $table->tinyInteger('used_flag')->default(0)->comment('利用済みフラグ');
            $table->timestamps();
            $table->unique(['user_id', 'stamp_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_store_stamps');
    }
};
