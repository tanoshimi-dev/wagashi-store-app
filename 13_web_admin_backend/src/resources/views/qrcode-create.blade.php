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

        <!-- <div class="m-2 lg:flex lg:items-center lg:justify-between">
            <div class="min-w-0 flex-1">
                <h2 class="text-2xl/7 font-bold text-gray-900 sm:truncate sm:text-3xl sm:tracking-tight">QRコード発行</h2>
                <div class="mt-1 flex flex-col sm:mt-0 sm:flex-row sm:flex-wrap sm:space-x-6">

                </div>
            </div>
        </div> -->


        <div class="relative bg-gray-800 px-6 py-32 sm:px-12 sm:py-40 lg:px-16">
            <div class="absolute inset-0 overflow-hidden">
                <img src="https://tailwindui.com/plus-assets/img/ecommerce-images/home-page-03-feature-section-full-width.jpg" alt="" class="size-full object-cover">
            </div>
            <div aria-hidden="true" class="absolute inset-0 bg-gray-900/50"></div>
            <div class="relative mx-auto flex max-w-3xl flex-col items-center text-center">
                <!-- <h2 class="text-3xl font-bold tracking-tight text-white sm:text-4xl">QRコード発行</h2> -->
                <p class="mt-3 text-xl text-white">下のボタンを押してQRコードを発行してください</p>
                <a href="/qrcode" class="mt-8 block w-full rounded-md border border-transparent bg-white px-8 py-3 text-base font-medium text-gray-900 hover:bg-gray-100 sm:w-auto">QRコード発行</a>
            </div>
        </div>


    
    </body>
</html>
