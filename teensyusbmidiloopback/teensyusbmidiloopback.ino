#define BLINK 0

void setup() {
#if BLINK == 1
  pinMode(LED_BUILTIN, OUTPUT);
#endif
}

void loop() {
#if BLINK == 1
  static elapsedMillis m;
  if (m >= 500) {
    m = 0;
    digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
  }
#endif
  if (uint32_t r = usb_midi_read_message())
    usb_midi_write_packed(r);
}
