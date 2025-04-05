<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\URL;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        if (config('app.env') === 'production') {
            URL::forceScheme('https');
            
            // Deshabilitar Vite en producción
            \Illuminate\Foundation\Vite::macro('useBuildDirectory', function () {
                return $this;
            });
            
            \Illuminate\Foundation\Vite::macro('useHotFile', function () {
                return $this;
            });
            
            \Illuminate\Foundation\Vite::macro('withEntryPoints', function () {
                return $this;
            });
        }
    }
}