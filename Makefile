_test: clean build

build:
	@gulp test

clean:
	@clear
	@rm -rf lib
	@rm -rf test/templates
	@mkdir lib
