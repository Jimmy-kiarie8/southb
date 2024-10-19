<?php

namespace App\Http\Middleware;

use Carbon\Carbon;
use Closure;
use Illuminate\Http\Request;

class TrialMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {

        // Replace '2023-09-30' with the date you want to compare against.
        $targetDate = '2024-07-30';

        if (Carbon::now() > Carbon::parse($targetDate)) {
            abort(403, 'Something went wrong!');
        }

        return $next($request);
    }
}
