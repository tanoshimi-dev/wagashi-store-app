<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

use App\Models\AdminUser;

class AdminUserAuthController extends Controller
{

    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
        ]);

        $user = AdminUser::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return response()->json(['user' => $user], 201);
    }

    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (Auth::guard('admin-web')->attempt($credentials)) {
            $user = Auth::guard('admin-web')->user();
            $token = $user->createToken('authToken')->plainTextToken;

            $request->session()->regenerate();
            $request->session()->regenerateToken();

            // return response()->json([
            //     'token' => $token,
            //     'user' => $user
            // ], 200);
            return view('dashboard');
        }

        return response()->json(['error' => 'Invalid credentials'], 401);

        
    }

    public function logout(Request $request)
    {
        //$request->user()->tokens()->delete();
        //Auth::guard('admin-web')->user()->tokens()->delete();

        $user = Auth::guard('admin-web')->user();

        if (!$user) {
            return new JsonResponse([
                'message' => 'Already Unauthenticated.',
            ]);
        }

        Auth::guard('admin-web')->logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        $user->tokens()->delete();

        //return response()->json(['message' => 'Logged out']);
        return view('dashboard');
    }

    public function user(Request $request)
    {

        
        // return response()->json($request->user());
        return response()->json(Auth::guard('admin-web')->user());
    }
}