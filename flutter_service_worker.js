'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"manifest.json": "f2c2dd66e52f29ee2552756c83abf0a7",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js": "ef607b11268dfd3ce7bf49795a95084a",
"version.json": "7b7e3ab9f601a639bbcb5d682157a166",
"assets/NOTICES": "aa8bc091622bf119c88ab4972a7e0f00",
"assets/fonts/MaterialIcons-Regular.otf": "4ce2bb95a3e21a3e454a793fb743e4a7",
"assets/AssetManifest.json": "6b240cd73857bbed6969a97bb6505dbb",
"assets/assets/fonts/PoetsenOne-Regular.ttf": "e7f249e71a563eed9c495835657eb9c2",
"assets/assets/audio/plant_cycle/es/Pro-planatadulta.mp3": "d43c8b7fa64ecef2d230887230298bb3",
"assets/assets/audio/plant_cycle/es/Pro-Semilias.mp3": "dca18ebd212f0befe76373ac451eab4a",
"assets/assets/audio/plant_cycle/es/Pro-plantula.mp3": "c416ed9cf70686a17e13fc12d0cfd53a",
"assets/assets/audio/plant_cycle/es/Pro-Germinacion.mp3": "1f7245db7072478cf40fda4ace772743",
"assets/assets/audio/plant_cycle/es/Pro-Floracion.mp3": "dc35581f49bcfc2ecbd2f81d58c2731f",
"assets/assets/audio/plant_cycle/stages/PCEX-S2-Germination.mp3": "c856a72a41084abbd41adb4ebb4a733c",
"assets/assets/audio/plant_cycle/stages/PCEX-S4-AdultPlant.mp3": "e6d46dbbeef3566d419eafd43d95ca3e",
"assets/assets/audio/plant_cycle/stages/PCEX-S1-Seeds.mp3": "964e2a51723633498ae51f3e9686eaeb",
"assets/assets/audio/plant_cycle/stages/PCEX-S3-Seedling.mp3": "4ed44dfbc3c7a6160201b59e09e4fede",
"assets/assets/audio/plant_cycle/stages/PCEX-S5-Flowering.mp3": "d1671b9689a2fcd42b09b54b08bace7b",
"assets/assets/audio/plant_cycle/en/Pro-Seedling.mp3": "142488a741d59cf6a0aafa65a2410035",
"assets/assets/audio/plant_cycle/en/Pro-Seeds.mp3": "fbcadde83be9c971c35b53826333da33",
"assets/assets/audio/plant_cycle/en/Pro-Germination.mp3": "f13562373958c8ae17c49f0a7b8fd200",
"assets/assets/audio/plant_cycle/en/Pro-Flowering.mp3": "9daa856c8202ca9b84c875b3fe41a0d6",
"assets/assets/audio/plant_cycle/en/Pro-Adultplant.mp3": "43fcc63732fd1b2e7a095fe65ef0d3c6",
"assets/assets/audio/water_cycle/es/Pro-FlujodeAguaSubterranea.mp3": "412a660751d69ea08aa0cabe98d54ae1",
"assets/assets/audio/water_cycle/es/Pro-Evaporacion.mp3": "9ac1ac18a21d71911c6883ae93d1f89e",
"assets/assets/audio/water_cycle/es/Pro-Acumulacion.mp3": "0961a212205e7a00d5919bbc7cffaf20",
"assets/assets/audio/water_cycle/es/Pro-Condensacion.mp3": "f08cdd7e6f4513ff3603750419a133ed",
"assets/assets/audio/water_cycle/es/Pro-Precipitacion.mp3": "a2d0f6c0d62a04775f11e84c4b3f96ee",
"assets/assets/audio/water_cycle/stages/WCEX-S1-Evaporation.mp3": "768b7d265d71a221454025501abfd5fe",
"assets/assets/audio/water_cycle/stages/WCEX-S4-Groundwater.mp3": "7e807d04059089e885ba2396e23fa9a7",
"assets/assets/audio/water_cycle/stages/WCEX-S3-Precipitation.mp3": "4645ffe4c42bc16c35385f57c48a1185",
"assets/assets/audio/water_cycle/stages/WCEX-S5-Collection.mp3": "e7c24baea8a97aa73156b2ab930cd5eb",
"assets/assets/audio/water_cycle/stages/WCEX-S2-Condensation.mp3": "1af109525754ad75f109e70fa6b367a6",
"assets/assets/audio/water_cycle/en/Pro-Condensation.mp3": "ee0937c3ab3cb19a6a9f951d7bc838f8",
"assets/assets/audio/water_cycle/en/Pro-Groundwaterflow.mp3": "eb8d35bdabb00e27d578ee019f95d4f7",
"assets/assets/audio/water_cycle/en/Pro-Precipitation.mp3": "f492bf6a0e323f2cf124fe5877669cca",
"assets/assets/audio/water_cycle/en/Pro-Evaporation.mp3": "dcedf243605b6dc6def85cee449211c6",
"assets/assets/audio/water_cycle/en/Pro-Collection.mp3": "8d706691e0bc204ef1157d8f5048c620",
"assets/assets/images/rock_cycle.jpg": "3aa6fbdf59fda5f2724ebd2992cbc1a0",
"assets/assets/images/season_cycle.jpg": "cd727b749f634e161910541735040b18",
"assets/assets/images/frog_cycle/Froglet.png": "c5b5e1bd4972489d01f92b66d3638653",
"assets/assets/images/frog_cycle/adult_frog.png": "f5f040c5ad5495b698ef2514608a11df",
"assets/assets/images/frog_cycle/tadpole.png": "13c98f9133a3205c86e6888dcc436a47",
"assets/assets/images/frog_cycle/frog_egg.png": "194e66c192826448c8d0502fe0cca215",
"assets/assets/images/plant_cycle/adult_plant.png": "b71f83f7b3de3413bb5ab47cb42b706d",
"assets/assets/images/plant_cycle/flowering.png": "9a62ff2580f9d2960bc5c6934c0dc6ce",
"assets/assets/images/plant_cycle/seedling.png": "6f8352c597c89fb186b167501a63e4ea",
"assets/assets/images/plant_cycle/germination.png": "4b9f3cba15f1a874d5535d74556f760d",
"assets/assets/images/plant_cycle/seeds.png": "9c808f09abdf73e1ada7c59ed2ce204f",
"assets/assets/images/rock_cycle/sediments.png": "9f3ef033d598980fc36a8d20f5e84805",
"assets/assets/images/rock_cycle/sedimentary.png": "9d6b37dba74be499eef62ae9607a9236",
"assets/assets/images/rock_cycle/igneous.png": "8230b64d58424270370a2eb0c3d64e52",
"assets/assets/images/rock_cycle/metamorphic.png": "2e3769a1175f3c77cd68060f235c2992",
"assets/assets/images/frog_cycle.jpg": "ed938597deb4235bb741f328fa58a9ef",
"assets/assets/images/butterfly_cycle/caterpillar.png": "4b60787bc35baf1f8d2f440b64d7cd4e",
"assets/assets/images/butterfly_cycle/eggs.png": "7fd28b58e6e2c83fe1eef4d37b38bc5d",
"assets/assets/images/butterfly_cycle/butterfly.png": "7563edfe701103f7936069a2e0af26a9",
"assets/assets/images/butterfly_cycle/pupa.png": "2b65156b23a586325499490ec276b1b3",
"assets/assets/images/butterfly_cycle.jpg": "07cbfdb98f0a91a9999c2b1487a05e1a",
"assets/assets/images/plant_cycle.jpg": "a2919c78a1660703272a5b44699fac39",
"assets/assets/images/season_cycle/winter.png": "fb359ce8f90956983b9313cbffb855da",
"assets/assets/images/season_cycle/summer.png": "58a4586405a0500a1fd6187886575d44",
"assets/assets/images/season_cycle/spring.png": "074e61469d91161f47c336c4209297dd",
"assets/assets/images/season_cycle/autumn.png": "728bc7636269f5dcb8dbb4d321a495df",
"assets/assets/images/water_cycle/condensation.png": "2e82a35bb01506a152c7465437a68707",
"assets/assets/images/water_cycle/precipitation.png": "fa2a5d0934185c8c3bec180efbfc9d76",
"assets/assets/images/water_cycle/groundwater.png": "c5758f42a71e49d690f5816843dc382f",
"assets/assets/images/water_cycle/evaporation.png": "654d82079365b2da5aacb563c0d78f28",
"assets/assets/images/water_cycle/collection.png": "3e5e1f7bfce7cbff3a335d9dfa3c6948",
"assets/assets/images/water_cycle.jpg": "fd56da7d83a383be8f0ffb1d9445a198",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25203.gif": "0aa1149923dd773e96e95309f4a7b78a",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25201.gif": "5aa949518b95b251eaec6e65ae16b393",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25205.gif": "2341bfbb9da2c63938ac698efbd9d8e6",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25204.gif": "d901b88351a559775536fd5807f61ad1",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25202.gif": "5dd3cd4c82c1c985c47aaee6d12df654",
"assets/assets/animations/season_cycle/SeasonCycle_Stage%25203.gif": "a2ec2d4c5340563ebfae874e9725c346",
"assets/assets/animations/season_cycle/SeasonCycle_Stage%25204.gif": "7a096c36fd2b77b2c720ea44b5966cb3",
"assets/assets/animations/season_cycle/SeasonCycle_Stage%25202.gif": "77f98e0d16e686b4342a481e724789ed",
"assets/assets/animations/season_cycle/SeasonCycle_Stage%25201.gif": "fd23a935ac793734f72745ee27d930d7",
"assets/FontManifest.json": "a9acbfb1dd3b7084b02e8fd0b26886c7",
"assets/AssetManifest.bin.json": "a76747d5c3effd06813d9f1724a454b2",
"assets/AssetManifest.bin": "30fabaaa144bccb907ba7e81f4d8075a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"flutter_bootstrap.js": "2f32e9dc7b23029c2124be7d2136653d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "30f44d8b1072d6cafd8b41e81fe71e27",
"/": "30f44d8b1072d6cafd8b41e81fe71e27"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
