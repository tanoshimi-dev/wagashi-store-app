<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>

        <!-- Fonts -->

        <!-- Styles -->

        @vite('resources/css/app.css')
    </head>
    <body>
        <div class="bg-white">




            <div class="relative bg-gray-900">
                <!-- Decorative image and overlay -->
                <div aria-hidden="true" class="absolute inset-0 overflow-hidden">
                <img src="https://tailwindui.com/plus-assets/img/ecommerce-images/home-page-01-hero-full-width.jpg" alt="" class="size-full object-cover">
                </div>
                <div aria-hidden="true" class="absolute inset-0 bg-gray-900 opacity-50"></div>




                <div class="relative mx-auto flex max-w-3xl flex-col items-center px-6 pt-2 pb-24 text-center sm:py-64 lg:px-0">
                    <h1 class="text-4xl font-bold tracking-tight text-white lg:text-6xl">QRコード</h1>
                    <div class="m-2">
                        <img src="/image/qrcode.png" alt="" class="size-full object-cover">
                    </div>
                    <p class="mt-4 text-xl text-white">スマートフォンのカメラで読み込んでください</p>
                </div>
            </div>
        </div>
    </body>
</html>
