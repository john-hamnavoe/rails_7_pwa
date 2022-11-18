# README

Rails 7 application that is PWA enabled. A few tweaks to drifting ruby approach on Rails 6 and webpacker, which was based a bit on serviceworker-rails gem.

## Rails 7 Setup

* esbuild 
* postgresql 
* tailwindcss

## PWA Changes

In order to get PWA to work with Rails 7, I had to make the following changes:

### Routes

Add these routes to `config/routes.rb`:
```
  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'
```

### Icons

Create a couple of icons sized 192x192 and 512x512 and place them in `app/assets/images/`

### Service Workers Controllers

Create a `service_workers` folder in `app/controllers` and add the following files:

`app/controllers/service_workers/workers_controller.rb`
`app/controllers/service_workers/manifests_controller.rb`

In the workers controller, add the following:

```protect_from_forgery except: :index```

### Service Workers Views

Create a `service_workers` folder in `app/views` and add the following files:

`app/views/service_workers/workers/index.js.erb`
`app/views/service_workers/manifests/index.json.jbuilder`

In the `index.js.erb` file I used variation of approach from https://dev.to/mikerogers0/how-to-make-rails-work-offline-pwa-p05
That was webpacker based, so I had to tweak it a bit to work with esbuild.
It allowed for offline mode and caching of assets. Other examples were mostly about caching assets, but not offline mode.
Also seemed that the NetworkFirst strategy was not working for me, a page would only go into cache after I refreshed it.
So change registerRoute to use specific routes instead of what was there.
Seems to work though workbox was throughing some errors in the console, so not yet 100% solid.

Refer to the code for the `index.json.jbuilder` file.

### application.html.erb

Add the following lines to the `app/layouts/application.html.erb` file:

```
    <link rel="manifest" crossorigin="use-credentials" href="/manifest.json">
    <meta name="theme-color" content="#8e2731">
```

The cross origin was need to get ngrok to work with the manifest file. Otherwise it would throw an invalid manifest file error in the console. 

### application.js

Add the following lines to the `app/javascript/application.js` file:

```
if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
                         .then(function(registration) {
                           console.log('[Companion]', 'Service worker registered!')
                           console.log(registration)
                         })
}
```

## Testing with ngrok 

I used ngrok to test as it will allow you to test with SSL. 

### Install ngrok

Simpliest to create free account with ngrok. 

Then follow instractions here to install 
https://dashboard.ngrok.com/get-started/setup

You can use brew to install on a mac if you want. 

### development.rb

Add the following to `config/environments/development.rb`:

```
  config.hosts << /[a-z0-9.-]+\.ngrok\.io/
```

### Run ngrok

Run rails application as normal ./bin/dev

Then run ngrok ./ngrok http 3000 in another terminal 

There should be a https url that you can use to test the PWA shown in console something like this: 

Forwarding                    https://ea35-99-999-99-999.eu.ngrok.io -> http://localhost:3000      

### Test PWA

Open the https url in chrome and you should see the PWA install prompt.

### PWA Compliance 

On chrome you can check the PWA compliance by going to the developer tools and clicking on the Lighthouse tab. Click the Analyze page load button and you should see the PWA compliance in the report. 

