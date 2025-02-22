<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\HelloController;
use App\Http\Controllers\Api\ProductsController;
use App\Http\Controllers\Api\HealthCheckController;
use App\Http\Controllers\Api\UsersController;
use App\Http\Controllers\Api\StoreStampController;


use App\Http\Controllers\AuthController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::get('/hello', HelloController::class);
Route::get('/messages', [HelloController::class, 'getMessages']);

// health check

Route::get('/products', ProductsController::class);

// user
//Route::get('/users', UsersController::class);


// mobile app user authentication
Route::post('/login', [AuthController::class, 'login']);
// Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
// Route::get('/user', [AuthController::class, 'user'])->middleware('auth:sanctum');

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('/register', [AuthController::class, 'register']);
Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::get('/user', [AuthController::class, 'user']);
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
    // stamp
    Route::post('/stamp', [StoreStampController::class, 'getStamp']);
    Route::post('/stamps', [StoreStampController::class, 'getStamps']);
});

