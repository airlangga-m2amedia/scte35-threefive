PY3 = python3
PIP3 = pip3
PYPY3 = pypy3

default: install

fmt:
	black threefive/
	black examples/
	black setup.py
	gofmt -s -w go/

commit: fmt
	git pull
	git commit -a
	git push	

clean:
	rm -f dist/*
	rm -rf build/*

pypy3: clean
	$(PYPY3) setup.py sdist bdist_wheel
	$(PYPY3) setup.py install	

install: clean pkg
	$(PY3)  setup.py install

pkg: clean
	$(PY3) setup.py sdist bdist_wheel

uninstall: clean
	$(PIP3) uninstall threefive
	
upload: clean pkg	
	twine upload dist/*

upgrade:
	$(PIP3) install --upgrade threefive
	
cli:
	sed -i s/pypy3/python3/ 35decode
	install 35decode /usr/local/bin
pypy3-cli:
	sed -i s/python3/pypy3/ 35decode
	install 35decode /usr/local/bin


