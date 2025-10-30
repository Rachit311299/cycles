'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "76f08d47ff9f5715220992f993002504",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "f2c2dd66e52f29ee2552756c83abf0a7",
"index.html": "30f44d8b1072d6cafd8b41e81fe71e27",
"/": "30f44d8b1072d6cafd8b41e81fe71e27",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "ae454de4ac2a83939fd50d5694d7a3b6",
"assets/assets/subtitles/plant_cycle/stages/PCEX-S1-Seeds.srt": "b56c3dd401e14aacaea019b96e6852eb",
"assets/assets/subtitles/plant_cycle/stages/PCEX-S4-AdultPlant.srt": "6764ec0c03a28a4a32a89dd1e1206267",
"assets/assets/subtitles/plant_cycle/stages/PCEX-S2-Germination.srt": "56ada5577f1cb8683a184157c8b8b01c",
"assets/assets/subtitles/plant_cycle/stages/PCEX-S3-Seedling.srt": "847eca4e3ebd0a7e53122e41c4e03915",
"assets/assets/subtitles/plant_cycle/stages/PCEX-S5-Flowering.srt": "3cab58f0486790824ce0e75fb1d81ce9",
"assets/assets/images/moon_cycle.jpg": "d2ea8b6ba2d044c1b7eb635a345014c2",
"assets/assets/images/frog_cycle/Froglet.png": "c5b5e1bd4972489d01f92b66d3638653",
"assets/assets/images/frog_cycle/adult_frog.png": "f5f040c5ad5495b698ef2514608a11df",
"assets/assets/images/frog_cycle/frog_egg.png": "194e66c192826448c8d0502fe0cca215",
"assets/assets/images/frog_cycle/tadpole.png": "13c98f9133a3205c86e6888dcc436a47",
"assets/assets/images/frog_cycle.jpg": "ed938597deb4235bb741f328fa58a9ef",
"assets/assets/images/day_night_cycle.jpg": "3ebbf9fd8ffefabf2ba5cbe8e14639b1",
"assets/assets/images/rock_cycle.jpg": "3aa6fbdf59fda5f2724ebd2992cbc1a0",
"assets/assets/images/moon_cycle/waning_crescent.png": "7001063d8c1a1cde1c2cbe9ce9c3c10c",
"assets/assets/images/moon_cycle/waxing_crescent.png": "6b91544d5194efda18b25d24ecba1b4f",
"assets/assets/images/moon_cycle/new_moon.png": "4109e7480f8761ab6df4305c98e2354e",
"assets/assets/images/moon_cycle/waning_gibbous.png": "ef5212078f555bb499698d51c8df771e",
"assets/assets/images/moon_cycle/last_quarter.png": "a63ec7aee9c9d9a19c1c0625022049d3",
"assets/assets/images/moon_cycle/first_quarter.png": "09d27967b856e7b9fd47a87bb7b07975",
"assets/assets/images/moon_cycle/full_moon.png": "e53191d9ab51045d7c0208610708e109",
"assets/assets/images/moon_cycle/waxing_gibbous.png": "fb6fa18c58f951bd2dae1aca28c3f2dd",
"assets/assets/images/butterfly_cycle/eggs.png": "7fd28b58e6e2c83fe1eef4d37b38bc5d",
"assets/assets/images/butterfly_cycle/butterfly.png": "7563edfe701103f7936069a2e0af26a9",
"assets/assets/images/butterfly_cycle/caterpillar.png": "4b60787bc35baf1f8d2f440b64d7cd4e",
"assets/assets/images/butterfly_cycle/pupa.png": "2b65156b23a586325499490ec276b1b3",
"assets/assets/images/season_cycle.jpg": "cd727b749f634e161910541735040b18",
"assets/assets/images/day_night_cycle/morning.jpg": "da3c846a3fd02ee606e81ad7ee4da9f0",
"assets/assets/images/day_night_cycle/sunrise.jpg": "5d93821dc02c6dff239fdf0c76c5ae45",
"assets/assets/images/day_night_cycle/night.jpg": "2d58cdef0a83924012b6b82ea35560c5",
"assets/assets/images/day_night_cycle/evening.jpg": "9c0e151aa78732f9e8a649876f5f8c06",
"assets/assets/images/day_night_cycle/afternoon.jpg": "6cb085ea5f5b25c38633dc1581ab3a3e",
"assets/assets/images/plant_cycle.jpg": "a2919c78a1660703272a5b44699fac39",
"assets/assets/images/water_cycle.jpg": "fd56da7d83a383be8f0ffb1d9445a198",
"assets/assets/images/season_cycle/autumn.png": "728bc7636269f5dcb8dbb4d321a495df",
"assets/assets/images/season_cycle/winter.png": "fb359ce8f90956983b9313cbffb855da",
"assets/assets/images/season_cycle/spring.png": "074e61469d91161f47c336c4209297dd",
"assets/assets/images/season_cycle/summer.png": "58a4586405a0500a1fd6187886575d44",
"assets/assets/images/butterfly_cycle.jpg": "07cbfdb98f0a91a9999c2b1487a05e1a",
"assets/assets/images/water_cycle/groundwater.png": "c5758f42a71e49d690f5816843dc382f",
"assets/assets/images/water_cycle/precipitation.png": "fa2a5d0934185c8c3bec180efbfc9d76",
"assets/assets/images/water_cycle/condensation.png": "2e82a35bb01506a152c7465437a68707",
"assets/assets/images/water_cycle/evaporation.png": "654d82079365b2da5aacb563c0d78f28",
"assets/assets/images/water_cycle/collection.png": "3e5e1f7bfce7cbff3a335d9dfa3c6948",
"assets/assets/images/rock_cycle/metamorphic.png": "2e3769a1175f3c77cd68060f235c2992",
"assets/assets/images/rock_cycle/sedimentary.png": "9d6b37dba74be499eef62ae9607a9236",
"assets/assets/images/rock_cycle/igneous.png": "8230b64d58424270370a2eb0c3d64e52",
"assets/assets/images/rock_cycle/sediments.png": "9f3ef033d598980fc36a8d20f5e84805",
"assets/assets/images/plant_cycle/flowering.png": "9a62ff2580f9d2960bc5c6934c0dc6ce",
"assets/assets/images/plant_cycle/seeds.png": "9c808f09abdf73e1ada7c59ed2ce204f",
"assets/assets/images/plant_cycle/adult_plant.png": "b71f83f7b3de3413bb5ab47cb42b706d",
"assets/assets/images/plant_cycle/seedling.png": "6f8352c597c89fb186b167501a63e4ea",
"assets/assets/images/plant_cycle/germination.png": "4b9f3cba15f1a874d5535d74556f760d",
"assets/assets/fonts/PoetsenOne-Regular.ttf": "e7f249e71a563eed9c495835657eb9c2",
"assets/assets/audio/water_cycle/en/Pro-Precipitation.mp3": "6d823e8da74468a3982c57470f8f650e",
"assets/assets/audio/water_cycle/en/Pro-Collection.mp3": "ef5a305f72e53b902a99e92175008679",
"assets/assets/audio/water_cycle/en/Pro-Evaporation.mp3": "1ec0808848e1b69dfc2a95cdadebcfe3",
"assets/assets/audio/water_cycle/en/Pro-Condensation.mp3": "8bbc5252dddc81bd1890eea126dafd4f",
"assets/assets/audio/water_cycle/en/Pro-Groundwaterflow.mp3": "e936e283487dbc1286cb11869a798552",
"assets/assets/audio/water_cycle/es/Pro-Condensacion.mp3": "8faa5ce5392e7f74827830829cecf842",
"assets/assets/audio/water_cycle/es/Pro-Precipitacion.mp3": "2368c8d72932fc4fb331182f12d85d38",
"assets/assets/audio/water_cycle/es/Pro-FlujodeAguaSubterranea.mp3": "86d680d8e2514d01c77e1a02e2dec230",
"assets/assets/audio/water_cycle/es/Pro-Acumulacion.mp3": "2a99576c1beae3c29ef8ce0a529151ea",
"assets/assets/audio/water_cycle/es/Pro-Evaporacion.mp3": "4e91ae510a5dbcedcd62e6c9e64db9b3",
"assets/assets/audio/water_cycle/stages/en/WCEXen-S1-Evaporation.mp3": "3238e061a562c0d3cc59a0474baca078",
"assets/assets/audio/water_cycle/stages/en/WCEXen-S3-Precipitation.mp3": "0a6946e27e16a53a758790b3a73d410c",
"assets/assets/audio/water_cycle/stages/en/WCEXen-S4-Groundwater.mp3": "2f101ec3d028a0f0457b2c3dcfdd6c77",
"assets/assets/audio/water_cycle/stages/en/WCEXen-S5-Collection.mp3": "2aef5e32f21cba3a8e69949eb2376e18",
"assets/assets/audio/water_cycle/stages/en/WCEXen-S2-Condensation.mp3": "e5ea5b79fae3b6c8c86f994d1074bde4",
"assets/assets/audio/water_cycle/stages/es/WCEXes-S4-Groundwater.mp3": "7992b3c285944a36112df4952fc87041",
"assets/assets/audio/water_cycle/stages/es/WCEXes-S5-Collection.mp3": "f04b51350410c68f73fdb6a926cbf814",
"assets/assets/audio/water_cycle/stages/es/WCEXes-S3-Precipitation.mp3": "9ba7cb61ec3652420edb9888f89ecc6c",
"assets/assets/audio/water_cycle/stages/es/WCEXes-S2-Condensation.mp3": "79437aaa5b8bce9f26f66d5d8fb0795c",
"assets/assets/audio/water_cycle/stages/es/WCEXes-S1-Evaporation.mp3": "0c05954f915cb74ca5c2e48daca020da",
"assets/assets/audio/plant_cycle/en/Pro-Adultplant.mp3": "39fcbfc660fb814bb551e97ce99c7623",
"assets/assets/audio/plant_cycle/en/Pro-Flowering.mp3": "e6ac97fa4080cca13361e23e65190a35",
"assets/assets/audio/plant_cycle/en/Pro-Seeds.mp3": "f6184623ee1f692b8f5e72a579ce5807",
"assets/assets/audio/plant_cycle/en/Pro-Seedling.mp3": "b3cb5917400a0779eb27330aea6b31a4",
"assets/assets/audio/plant_cycle/en/Pro-Germination.mp3": "cdbd33964e1235318fec8d2f23a4add6",
"assets/assets/audio/plant_cycle/es/Pro-Floracion.mp3": "35cce93318f47c631756042a690444b7",
"assets/assets/audio/plant_cycle/es/Pro-plantula.mp3": "90f417266f6de3928b6426c3594c5aaf",
"assets/assets/audio/plant_cycle/es/Pro-Germinacion.mp3": "074999b9876e7169ab1a14b9932c1715",
"assets/assets/audio/plant_cycle/es/Pro-Semilias.mp3": "e9614a0620be942495c1cb9c4dcc1b0e",
"assets/assets/audio/plant_cycle/es/Pro-planatadulta.mp3": "b9dbca5d743210d574715f007165b61b",
"assets/assets/audio/plant_cycle/stages/en/PCEXen-S1-Seeds.mp3": "43a0670a509e13933bea6e92312b775b",
"assets/assets/audio/plant_cycle/stages/en/PCEXen-S2-Germination.mp3": "b4a984f0ce3d7281aa391abd25a7c5fb",
"assets/assets/audio/plant_cycle/stages/en/PCEXen-S5-Flowering.mp3": "a83166914ca132925b79331f9a35d2be",
"assets/assets/audio/plant_cycle/stages/en/PCEXen-S3-Seedling.mp3": "59d62205c5cc0d420f4c5e77e0c690e2",
"assets/assets/audio/plant_cycle/stages/en/PCEXen-S4-AdultPlant.mp3": "8cb8d302fe3947a2f068f3c71655cf15",
"assets/assets/audio/plant_cycle/stages/es/PCEXes-S1-Seeds.mp3": "dafebbd9e369ff696d37af27713b8c55",
"assets/assets/audio/plant_cycle/stages/es/PCEXes-S4-AdultPlant.mp3": "eb605bfa3948e8a11efe4df079c062d0",
"assets/assets/audio/plant_cycle/stages/es/PCEXes-S3-Seedling.mp3": "b40feec4d92ff835605a77734ddc7604",
"assets/assets/audio/plant_cycle/stages/es/PCEXes-S5-Flowering.mp3": "b9d7b5940ac8d0b7b2d79d9a4de545c8",
"assets/assets/audio/plant_cycle/stages/es/PCEXes-S2-Germination.mp3": "1e672d7710a882a42cd25b31e7ec26bc",
"assets/assets/animations/season_cycle/SeasonCycle_Stage%25201.gif": "fd23a935ac793734f72745ee27d930d7",
"assets/assets/animations/season_cycle/SeasonCycle_Stage%25202.gif": "77f98e0d16e686b4342a481e724789ed",
"assets/assets/animations/season_cycle/SeasonCycle_Stage%25203.gif": "a2ec2d4c5340563ebfae874e9725c346",
"assets/assets/animations/season_cycle/SeasonCycle_Stage%25204.gif": "7a096c36fd2b77b2c720ea44b5966cb3",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25205.gif": "2341bfbb9da2c63938ac698efbd9d8e6",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25203.gif": "0aa1149923dd773e96e95309f4a7b78a",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25201.gif": "5aa949518b95b251eaec6e65ae16b393",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25204.gif": "d901b88351a559775536fd5807f61ad1",
"assets/assets/animations/plant_cycle/PlantCycle_Stage%25202.gif": "5dd3cd4c82c1c985c47aaee6d12df654",
"assets/fonts/MaterialIcons-Regular.otf": "2d2416f901695ba8a78dc283fd6ff1cf",
"assets/NOTICES": "aa8bc091622bf119c88ab4972a7e0f00",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "a9acbfb1dd3b7084b02e8fd0b26886c7",
"assets/AssetManifest.bin": "9fe838d8240444ea2f2f0ad4fb13f15f",
"assets/AssetManifest.json": "faa567100e5de686b3c6b89f5c1e684d",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "aeca601594619165d7d6583ca34a1283",
"version.json": "7b7e3ab9f601a639bbcb5d682157a166",
"main.dart.js": "f0c8864d9bbebb7e579b7e1e5a5575f4"};
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
