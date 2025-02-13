<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AdminUserAuthController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

// Route::group(['middleware' => ['auth:admin']], function () {
//     Route::get('/user', [AuthController::class, 'user']);
//     Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
// });


Route::get('/admin/user', [AdminUserAuthController::class, 'user']);
Route::post('/admin/user/login', [AdminUserAuthController::class, 'login']);
Route::post('/admin/user/register', [AdminUserAuthController::class, 'register']);


Route::group(['middleware' => ['auth:admin-web']], function () {
    Route::get('/qrcode-create', function () {
        return view('qrcode-create');
    });
    Route::post('/admin/user/logout', [AdminUserAuthController::class, 'logout']);    
});
Route::get('/qrcode', function () {
    return view('qrcode');
});
