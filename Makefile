_test: clean build mocha

mocha:
	@mocha

build:
	@./node_modules/coffee-script/bin/coffee \
		-c \
		-o lib src

clean:
	@rm -rf lib
	@mkdir lib
