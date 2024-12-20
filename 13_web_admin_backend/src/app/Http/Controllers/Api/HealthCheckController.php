<?php declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

final class HealthCheckController extends Controller
{
    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function __invoke(Request $request): JsonResponse
    {
        return new JsonResponse([
            'data' => [
                'message' => 'hello world!',
                'yoour_number' => random_int(1,100),
            ],
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
    public function getUsers(Request $request): JsonResponse
    {
        // DBからデータを取得する
        $rows = DB::connection('mysql')->table('users')
            ->orderBy('id', 'asc')->get();

        //dd($rows);
        return new JsonResponse([
            'data' => $rows,
        ]);
    } 



}

