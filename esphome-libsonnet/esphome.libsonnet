// https://esphome.io/components/esphome.html

local board_platforms = {
  d1: 'ESP8266',
  d1_mini: 'ESP8266',
  d1_mini_lite: 'ESP8266',
  d1_mini_pro: 'ESP8266',
  esp01: 'ESP8266',
  esp01_1m: 'ESP8266',
  esp07: 'ESP8266',
  esp12e: 'ESP8266',
  esp210: 'ESP8266',
  esp8285: 'ESP8266',
  esp_wroom_02: 'ESP8266',
  espduino: 'ESP8266',
  espectro: 'ESP8266',
  espino: 'ESP8266',
  espinotee: 'ESP8266',
  espresso_lite_v1: 'ESP8266',
  espresso_lite_v2: 'ESP8266',
  gen4iod: 'ESP8266',
  heltec_wifi_kit_8: 'ESP8266',
  huzzah: 'ESP8266',
  inventone: 'ESP8266',
  modwifi: 'ESP8266',
  nodemcu: 'ESP8266',
  nodemcuv2: 'ESP8266',
  oak: 'ESP8266',
  phoenix_v1: 'ESP8266',
  phoenix_v2: 'ESP8266',
  sparkfunBlynk: 'ESP8266',
  thing: 'ESP8266',
  thingdev: 'ESP8266',
  wifi_slot: 'ESP8266',
  wifiduino: 'ESP8266',
  wifinfo: 'ESP8266',
  wio_link: 'ESP8266',
  wio_node: 'ESP8266',
  xinabox_cw01: 'ESP8266',
  alksesp32: 'ESP32',
  'bpi-bit': 'ESP32',
  'd-duino-32': 'ESP32',
  'esp-wrover-kit': 'ESP32',
  'esp32-devkitlipo': 'ESP32',
  'esp32-evb': 'ESP32',
  'esp32-gateway': 'ESP32',
  'esp32-poe': 'ESP32',
  'esp32-poe-iso': 'ESP32',
  'esp32-pro': 'ESP32',
  esp320: 'ESP32',
  esp32cam: 'ESP32',
  esp32dev: 'ESP32',
  'esp32doit-devkit-v1': 'ESP32',
  esp32thing: 'ESP32',
  'esp32vn-iot-uno': 'ESP32',
  espea32: 'ESP32',
  espectro32: 'ESP32',
  espino32: 'ESP32',
  featheresp32: 'ESP32',
  firebeetle32: 'ESP32',
  'fm-devkit': 'ESP32',
  frogboard: 'ESP32',
  heltec_wifi_kit_32: 'ESP32',
  heltec_wifi_lora_32: 'ESP32',
  heltec_wifi_lora_32_V2: 'ESP32',
  heltec_wireless_stick: 'ESP32',
  hornbill32dev: 'ESP32',
  hornbill32minima: 'ESP32',
  intorobot: 'ESP32',
  iotaap_magnolia: 'ESP32',
  iotbusio: 'ESP32',
  iotbusproteus: 'ESP32',
  lolin32: 'ESP32',
  lolin_d32: 'ESP32',
  lolin_d32_pro: 'ESP32',
  lopy: 'ESP32',
  lopy4: 'ESP32',
  'm5stack-core-esp32': 'ESP32',
  'm5stack-fire': 'ESP32',
  'm5stack-grey': 'ESP32',
  'm5stick-c': 'ESP32',
  magicbit: 'ESP32',
  mhetesp32devkit: 'ESP32',
  mhetesp32minikit: 'ESP32',
  'microduino-core-esp32': 'ESP32',
  nano32: 'ESP32',
  nina_w10: 'ESP32',
  node32s: 'ESP32',
  'nodemcu-32s': 'ESP32',
  odroid_esp32: 'ESP32',
  onehorse32dev: 'ESP32',
  oroca_edubot: 'ESP32',
  pico32: 'ESP32',
  pocket_32: 'ESP32',
  pycom_gpy: 'ESP32',
  quantum: 'ESP32',
  'sparkfun_lora_gateway_1-channel': 'ESP32',
  tinypico: 'ESP32',
  'ttgo-lora32-v1': 'ESP32',
  'ttgo-t-beam': 'ESP32',
  'ttgo-t-watch': 'ESP32',
  'ttgo-t1': 'ESP32',
  turta_iot_node: 'ESP32',
  'vintlabs-devkit-v1': 'ESP32',
  wemos_d1_mini32: 'ESP32',
  wemosbat: 'ESP32',
  wesp32: 'ESP32',
  'widora-air': 'ESP32',
  xinabox_cw: 'ESP32',
};

{
  board_platforms: board_platforms,
  new(
    config, mixins,
  )::
    {
      name: std.strReplace(config.name, '-', '_'),
      board: if std.objectHas(config, 'board') then config.board else 'nodemcuv2',
      platform: board_platforms[if std.objectHas(config, 'board') then config.board else 'nodemcuv2'],
      [if std.objectHas(config, 'description') || std.objectHas(config, 'address') then 'comment']:
        if std.objectHas(config, 'description') then config.description else
          if std.objectHas(config, 'address') then 'IP: ' + config.address else '',
      [if std.length(std.set(
        std.flattenArrays([
          mixins._config.entity[mixin.kind](mixin).includes
          for mixin in config.mixins
          if std.objectHas(mixins._config.entity[mixin.kind](mixin), 'includes')
        ])
      )) > 0 then 'includes']: std.set(
        std.flattenArrays([
          mixins._config.entity[mixin.kind](mixin).includes
          for mixin in config.mixins
          if std.objectHas(mixins._config.entity[mixin.kind](mixin), 'includes')
        ])
      ),
      [if std.length(std.set(
        std.flattenArrays([
          mixins._config.entity[mixin.kind](mixin).libraries
          for mixin in config.mixins
          if std.objectHas(mixins._config.entity[mixin.kind](mixin), 'libraries')
        ])
      )) > 0 then 'libraries']: std.set(
        std.flattenArrays([
          mixins._config.entity[mixin.kind](mixin).libraries
          for mixin in config.mixins
          if std.objectHas(mixins._config.entity[mixin.kind](mixin), 'libraries')
        ])
      ),
      [if std.objectHas(config, 'on_boot') then 'on_boot']: config.on_boot,
      [if std.objectHas(config, 'on_shutdown') then 'on_shutdown']: config.on_shutdown,
      [if std.objectHas(config, 'on_loop') then 'on_loop']: config.on_loop,
    },
}
