REPORTER = nyan
TESTS = tests/*.js

test:
	@NODE_ENV=test ./node_modules/.bin/mocha --reporter $(REPORTER) $(TESTS)

.PHONY: test