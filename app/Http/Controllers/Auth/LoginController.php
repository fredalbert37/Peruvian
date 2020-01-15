<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades\Auth;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Validation\ValidationException;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = 'intranet';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

     /**
     * Redirect the user to the GitHub authentication page.
     *
     * @return \Illuminate\Http\Response
     */
    public function redirectToProvider()
    {
        return Socialite::driver('facebook')->redirect();
    }

    /**
     * Obtain the user information from GitHub.
     *
     * @return \Illuminate\Http\Response
     */
    public function handleProviderCallback()
    {

        $userSocial = Socialite::driver('facebook')->stateless()->user();
        $user = User::where('fb_id',$userSocial->id)->first();
        //return $userSocial->name;
        if(!$user){
            $user = new User();
            $user->name = $userSocial->name;
            $user->email= $userSocial->email;
            $user->save();
        }

        session(['user'=>$user]);
        return redirect('welcome');
        /*
        $findUser = User::where('email', $userSocial->email)->first();
        if($findUser){
            Auth::login($userSocial);
            return redirect('home');
        }else{

            $user = new User();
            $user->name = $userSocial->name;
            $user->email= $userSocial->email;
            $user->save();

            Auth::login($user->email);

            return redirect('home');
        }
        */

    }



}
