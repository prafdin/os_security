1. Исходные данные к лабораторной работе
	В папке src хранятся исходные файлы всех примеров, приведённых в тексте методички.
	В папке tasks располагаются файлы заданий: скомпилированные приложения (под Ubuntu Linux 5.4.0-70-generic, libc 2.27).



2. [ВАЖНО] Дабы максимально приблизить своё окружение к использованному при написании методички, можно создать виртуальную машину (или докер-контейнер...) с Ubuntu 18.04, ядро 5.4.0-70-generic, libc версии 2.27. В этом случае исправлять что-либо скорее всего не потребуется.



3. Настройка ОС

a. Обновление пакетов системы
Открываем терминал (<CTRL> + <ALT> + T)
```bash
	$ sudo apt update
	$ sudo apt upgrade
	$ reboot
```
Возможно, будет также предложено установить обновления через приложение Software Updater - выполните обновление с помощью приложения.


b. Настройка гостевой ОС
```bash
	$ sudo apt install linux-headers-`uname -r`
	$ sudo apt install build-essential
```

Монтируем диск Дополнений гостевой ОС (Guest Additions): выбираем Устройства/Подключить образ диска Дополнений гостевой ОС, в появившемся окне нажимаем Run и воодим пароль.
После установки образ диска можно извлечь.

Перезагружаем систему:
```bash
	$ reboot
```

Включаем двунаправленный буфер: Устройства/Общий буфер обмена/Двунаправленный

Подключаем общую папку:
  00.   создаём точку монтирования (папку) в гостевой ОС: выполняем в терминале 
  		`mkdir ~/shared`
  0.   добавляем пользователя в группу vboxsf: выполняем в терминале 
  		```bash
  			$ sudo usermod -aG vboxsf $USER
  			$ id
  		```
  		в списке идентификаторов должен появится id группы vboxsf (скорее всего gid=999)
  i.   открываем окно в vbox: Устройства/Общие папки/Настроить общие папки
  ii.  выделяем список "Папки Машины", нажимаем на пиктограмму добавления папки
  iii. задаём путь к папке (на хосте - на вашей системе), в нижней части окна в поле ввода "Folder" указываем название папки "Folder" (необходимо для монтирования вручную)
  iv.  выделяем пункт "Создать постоянную папку"
  v.   подключить папку
  		автоматически: выбрать пункт "Авто-подключение" и указать в поле "Точка подключения" путь `/home/x/shared`
  		вручную (рекомендуется): в терминале выполнить
  			`$ sudo mount -t vboxsf Folder ~/shared`



4. Установка IDA Freeware и gdb-peda

a. Устанавливаем IDA:
```bash
	$ cd ~/Downloads
	$ wget https://out7.hex-rays.com/files/idafree70_linux.run
	$ chmod u+x idafree70_linux.run
	$ ./idafree70_linux.run
	$
	$ chmod g+x ~/idafree-7.0/ida64
	$ chmod u+x ~/idafree-7.0/ida64
	$ ~/idafree-7.0/ida64
```
Также запустить IDA можно с помощью desktop entry, созданной инсталлятором на драбочем столе.


b. Устанавливаем gdb-peda:
```bash
	$ cd ~
	$ sudo apt install git
	$ git clone https://github.com/longld/peda.git ~/peda
	$ echo "source ~/peda/peda.py" >> ~/.gdbinit
	$ cd /tmp && gdb /bin/ls
```
Вы должны увидеть приглашение "gdb-peda$" - признак успешной установки.



5. Дополнительные настройки

a.	Для компиляции 32-битных приложений требуется установить пакет `gcc-multilib`:
	```bash
		$ sudo apt install gcc-multilib
	```

b.	Для корректной работы примеров требуется отключить ASLR:
	```bash
		$ sudo bash def_off
	```

c. Установка `glibc` 2.23 для выполнения третьего задания
Подсказки тут:
	i.   https://stackoverflow.com/a/52454710
	ii.  https://github.com/elkrejzi/system-management/blob/master/glibc%2032%20bit.txt
	iii. https://stackoverflow.com/questions/8004241/how-to-compile-glibc-32bit-on-an-x86-64-machine

```bash
	$ sudo apt install gawk
	$
	$ cd ~
	$ git clone git://sourceware.org/git/glibc.git
	$ cd glibc
	$ git checkout release/2.23/master
	$ 
	$ mkdir build
	$ cd build
	$ ../configure --prefix "$(pwd)/../lib/lib64" CFLAGS="-Wno-dangling-else -Wno-int-in-bool-context -Wno-format-overflow -Wno-format-truncation -Wno-nonnull -O2" --disable-werror 
	$ make -j `nproc`
	$ make install -j `nproc`
	$
	$ cd ..
	$ rm -rf build
	$ mkdir build
	$ cd build
	$ ../configure --prefix "$(pwd)/../lib/lib32" CFLAGS="-Wno-dangling-else -Wno-int-in-bool-context -Wno-format-overflow -Wno-format-truncation -Wno-nonnull -O2 -march=i686" CC="gcc -m32" CXX="g++ -m32"  i686-linux-gnu --disable-werror
	$ make -j `nproc`
	$ make install -j `nproc`
	$ 
	$ cd ~/glibc
	$ sudo cp -R lib /glibc-2.23
```
