KEY_FILE="crypto/ti-degenerate-key.pem"

.PHONY: clean

tiboot3.bin: x509_cert r-boot.bin m-boot.bin
	cat $^ > $@

x509_cert: openssl.config
	openssl req -new -x509 -key $(KEY_FILE) -nodes -outform DER -out $@ -config $< -sha512

openssl.config: crypto/openssl.config.template r-boot.bin m-boot.bin scripts/gen_openssl_template.sh
	scripts/gen_openssl_template.sh $^ $@

# For now this is just a dummy payload
m-boot.bin:
	dd if=/dev/zero of=$@ bs=1 count=4

r-boot.bin: r-boot
	arm-none-eabi-objcopy -O binary -j .text $< $@

r-boot: src/bootstrap/c_runtime.s
	arm-none-eabi-as $< -o $@

clean:
	git clean -Xf
