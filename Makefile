_test: clean build mocha

mocha:
	@mocha

build:
	@./node_modules/coffee-script/bin/coffee \
		-c \
		-o lib src

clean:
	@clear
	@rm -rf lib
	@rm -rf test/templates
	@mkdir lib
