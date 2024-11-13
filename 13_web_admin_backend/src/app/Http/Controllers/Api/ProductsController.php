<?php declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

final class ProductsController extends Controller
{
    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function __invoke(Request $request): JsonResponse
    {
        $products = DB::connection('mysql_wp')
            ->table('wp_posts')
            ->where('post_type', 'product')
            ->where('post_status', 'publish')
            ->get();

        return new JsonResponse([
            'data' => $products,
        ]);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function getMessages(Request $request): JsonResponse
    {
        return new JsonResponse([
            'data' => [
                [
                    'message' => 'message 1!',
                    'number' => random_int(1,100), 
                ],
                [
                    'message' => 'message 22!',
                    'number' => random_int(1,100), 
                ],
                [
                    'message' => 'message 333!',
                    'number' => random_int(1,100), 
                ],
            ],
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

