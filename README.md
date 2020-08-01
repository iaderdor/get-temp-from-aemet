# Get temp from AEMET

This is a simple script intended to get the temperature of one of the AEMET's stations and storing it on a file.

## Installing

This has been tested with ruby 2.7.0.

In first place, you should clone the repo where you like the most in your computer:

```
git clone https://github.com/iaderdor/get-temp-from-aemet.git
```

Then, you should install all the gems of the `Gemfile`.

```bash
cd get-temp-from-aemet
bundler install
```

In the last place, you have to add some configuration.
First, order an API key from [AEMET's open data](https://opendata.aemet.es/centrodedescargas/altaUsuario?) and copy inside the config file.
Then, you have to choose the station. Go to the [AEMET's stations webpage](http://www.aemet.es/es/eltiempo/observacion/ultimosdatos) and look up for the one you're interested in. One open, search for the string `Ind. climatológico` and copy it also to the config file.

## Use

Just execute the `.rb` file, and it will write the last temperature of the chosen station to a file inside `~/.temp-from-aemet`.

## Authors

* **Ismael Aderdor Domingo** - *Initial work* - [iaderdor](https://github.com/iaderdor)

## License

This project is licensed under the MIT License - see the [LICENCE.md](LICENCE.md) file for details
