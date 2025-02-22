<?php declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

final class StoreStampController extends Controller
{

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function getStamp(Request $request): JsonResponse
    {

        $appUser = $request->user();
        return new JsonResponse([
            'appUser' => $appUser,
            'code' => $request->input('qr_code'),
        ]);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function getStamps(Request $request): JsonResponse
    {

        $appUser = $request->user();
        $id = $appUser->id;
        $rows = DB::table('user_store_stamps')
            ->where('user_id', $id)
            ->where('used_flag', 0)
            ->orderBy('id', 'asc')->get();
        return new JsonResponse([
            'appUser' => $appUser,
            'rows' => $rows,
        ]);
    }

 
    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function getMenus(Request $request): JsonResponse
    {
        // DBからデータを取得する
        $rows = DB::table('menus')
            ->orderBy('id', 'asc')->get();

        //dd($rows);
        return new JsonResponse([
            'data' => $rows,
        ]);
    } 



}

