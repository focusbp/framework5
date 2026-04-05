<?php

class I18nSimple {

	private const JSON_DIR = __DIR__ . "/../app/lang/json";
	private static $cache = [];
	private $ctl;

	function __construct(Controller $ctl) {
		$this->ctl = $ctl;
	}

	function translate(string $key, array $params = [], ?string $lang = null): string {
		$key = trim($key);
		if ($key === "") {
			return "";
		}

		$setting = $this->ctl->get_setting();
		$language_code = $this->resolve_lang($lang, $setting);
		if ($language_code !== "en") {
			foreach ($this->get_translation_candidates($language_code, $setting) as $candidate) {
				$messages = self::load_language_messages($candidate);
				if (isset($messages[$key]) && trim((string) $messages[$key]) !== "") {
					return $this->replace_params((string) $messages[$key], $params);
				}
			}
		}

		$messages_en = self::load_language_messages("en");
		if (isset($messages_en[$key]) && trim((string) $messages_en[$key]) !== "") {
			return $this->replace_params((string) $messages_en[$key], $params);
		}

		return $this->replace_params($key, $params);
	}

	function resolve_lang(?string $lang = null, ?array $setting = null): string {
		$lang = strtolower(trim((string) $lang));
		if ($lang !== "") {
			return $lang;
		}

		return self::get_language_code_from_setting($setting ?? $this->ctl->get_setting());
	}

	private function replace_params(string $text, array $params): string {
		foreach ($params as $key => $value) {
			$text = str_replace("{" . $key . "}", (string) $value, $text);
		}
		return $text;
	}

	private function get_translation_candidates(string $language_code, ?array $setting): array {
		$candidates = [];
		$language_code = strtolower(trim($language_code));
		$locale_code = strtolower(trim(self::get_locale_code_from_setting($setting)));
		if ($locale_code !== "" && preg_match('/^[a-z]{2}-[a-z]{2}$/', $locale_code)) {
			[$locale_language] = explode("-", $locale_code, 2);
			if ($locale_language === $language_code) {
				$candidates[] = $locale_code;
			}
		}
		$candidates[] = $language_code;
		return array_values(array_unique($candidates));
	}

	static function get_language_code_from_setting(?array $setting): string {
		$code = strtolower(trim((string) ($setting["framework_language_code"] ?? "")));
		if (!preg_match('/^[a-z]{2}$/', $code)) {
			return "en";
		}
		return $code;
	}

	static function get_legacy_lang_code_from_setting(?array $setting): string {
		$code = self::get_language_code_from_setting($setting);
		if ($code === "ja") {
			return "jp";
		}
		return "en";
	}

	static function get_locale_code_from_setting(?array $setting): string {
		$locale = trim((string) ($setting["locale_code"] ?? ""));
		if (preg_match('/^[a-z]{2}-[A-Z]{2}$/', $locale)) {
			return $locale;
		}
		return self::get_default_locale_code_from_language_code(
			self::get_language_code_from_setting($setting)
		);
	}

	static function get_default_locale_code_from_language_code(string $language_code): string {
		$language_code = strtolower(trim($language_code));
		$map = [
			"ja" => "ja-JP",
			"en" => "en-US",
			"zh" => "zh-CN",
		];
		return $map[$language_code] ?? "en-US";
	}

	static function get_language_options(): array {
		return [
//			"aa" => "Afar",
//			"ab" => "Abkhazian",
//			"ae" => "Avestan",
//			"af" => "Afrikaans",
//			"ak" => "Akan",
//			"am" => "Amharic",
//			"an" => "Aragonese",
//			"ar" => "Arabic",
//			"as" => "Assamese",
//			"av" => "Avaric",
//			"ay" => "Aymara",
//			"az" => "Azerbaijani",
//			"ba" => "Bashkir",
//			"be" => "Belarusian",
//			"bg" => "Bulgarian",
//			"bh" => "Bihari",
//			"bi" => "Bislama",
//			"bm" => "Bambara",
//			"bn" => "Bengali",
//			"bo" => "Tibetan",
//			"br" => "Breton",
//			"bs" => "Bosnian",
//			"ca" => "Catalan",
//			"ce" => "Chechen",
//			"ch" => "Chamorro",
//			"co" => "Corsican",
//			"cr" => "Cree",
//			"cs" => "Czech",
//			"cu" => "Church Slavic",
//			"cv" => "Chuvash",
//			"cy" => "Welsh",
//			"da" => "Danish",
//			"de" => "German",
//			"dv" => "Divehi",
//			"dz" => "Dzongkha",
//			"ee" => "Ewe",
//			"el" => "Greek",
			"en" => "English",
//			"eo" => "Esperanto",
//			"es" => "Spanish",
//			"et" => "Estonian",
//			"eu" => "Basque",
//			"fa" => "Persian",
//			"ff" => "Fulah",
//			"fi" => "Finnish",
//			"fj" => "Fijian",
//			"fo" => "Faroese",
//			"fr" => "French",
//			"fy" => "Western Frisian",
//			"ga" => "Irish",
//			"gd" => "Scottish Gaelic",
//			"gl" => "Galician",
//			"gn" => "Guarani",
//			"gu" => "Gujarati",
//			"gv" => "Manx",
//			"ha" => "Hausa",
//			"he" => "Hebrew",
//			"hi" => "Hindi",
//			"ho" => "Hiri Motu",
//			"hr" => "Croatian",
//			"ht" => "Haitian",
//			"hu" => "Hungarian",
//			"hy" => "Armenian",
//			"hz" => "Herero",
//			"ia" => "Interlingua",
//			"id" => "Indonesian",
//			"ie" => "Interlingue",
//			"ig" => "Igbo",
//			"ii" => "Sichuan Yi",
//			"ik" => "Inupiaq",
//			"io" => "Ido",
//			"is" => "Icelandic",
//			"it" => "Italian",
//			"iu" => "Inuktitut",
			"ja" => "Japanese",
//			"jv" => "Javanese",
//			"ka" => "Georgian",
//			"kg" => "Kongo",
//			"ki" => "Kikuyu",
//			"kj" => "Kuanyama",
//			"kk" => "Kazakh",
//			"kl" => "Kalaallisut",
//			"km" => "Khmer",
//			"kn" => "Kannada",
//			"ko" => "Korean",
//			"kr" => "Kanuri",
//			"ks" => "Kashmiri",
//			"ku" => "Kurdish",
//			"kv" => "Komi",
//			"kw" => "Cornish",
//			"ky" => "Kirghiz",
//			"la" => "Latin",
//			"lb" => "Luxembourgish",
//			"lg" => "Ganda",
//			"li" => "Limburgan",
//			"ln" => "Lingala",
//			"lo" => "Lao",
//			"lt" => "Lithuanian",
//			"lu" => "Luba-Katanga",
//			"lv" => "Latvian",
//			"mg" => "Malagasy",
//			"mh" => "Marshallese",
//			"mi" => "Maori",
//			"mk" => "Macedonian",
//			"ml" => "Malayalam",
//			"mn" => "Mongolian",
//			"mr" => "Marathi",
//			"ms" => "Malay",
//			"mt" => "Maltese",
//			"my" => "Burmese",
//			"na" => "Nauru",
//			"nb" => "Norwegian Bokmal",
//			"nd" => "North Ndebele",
//			"ne" => "Nepali",
//			"ng" => "Ndonga",
//			"nl" => "Dutch",
//			"nn" => "Norwegian Nynorsk",
//			"no" => "Norwegian",
//			"nr" => "South Ndebele",
//			"nv" => "Navajo",
//			"ny" => "Chichewa",
//			"oc" => "Occitan",
//			"oj" => "Ojibwa",
//			"om" => "Oromo",
//			"or" => "Oriya",
//			"os" => "Ossetian",
//			"pa" => "Punjabi",
//			"pi" => "Pali",
//			"pl" => "Polish",
//			"ps" => "Pashto",
//			"pt" => "Portuguese",
//			"qu" => "Quechua",
//			"rm" => "Romansh",
//			"rn" => "Rundi",
//			"ro" => "Romanian",
//			"ru" => "Russian",
//			"rw" => "Kinyarwanda",
//			"sa" => "Sanskrit",
//			"sc" => "Sardinian",
//			"sd" => "Sindhi",
//			"se" => "Northern Sami",
//			"sg" => "Sango",
//			"si" => "Sinhala",
//			"sk" => "Slovak",
//			"sl" => "Slovenian",
//			"sm" => "Samoan",
//			"sn" => "Shona",
//			"so" => "Somali",
//			"sq" => "Albanian",
//			"sr" => "Serbian",
//			"ss" => "Swati",
//			"st" => "Southern Sotho",
//			"su" => "Sundanese",
//			"sv" => "Swedish",
//			"sw" => "Swahili",
//			"ta" => "Tamil",
//			"te" => "Telugu",
//			"tg" => "Tajik",
//			"th" => "Thai",
//			"ti" => "Tigrinya",
//			"tk" => "Turkmen",
//			"tl" => "Tagalog",
//			"tn" => "Tswana",
//			"to" => "Tonga",
//			"tr" => "Turkish",
//			"ts" => "Tsonga",
//			"tt" => "Tatar",
//			"tw" => "Twi",
//			"ty" => "Tahitian",
//			"ug" => "Uighur",
//			"uk" => "Ukrainian",
//			"ur" => "Urdu",
//			"uz" => "Uzbek",
//			"ve" => "Venda",
//			"vi" => "Vietnamese",
//			"vo" => "Volapuk",
//			"wa" => "Walloon",
//			"wo" => "Wolof",
//			"xh" => "Xhosa",
//			"yi" => "Yiddish",
//			"yo" => "Yoruba",
//			"za" => "Zhuang",
			"zh" => "Chinese",
//			"zu" => "Zulu",
		];
	}

	static function get_locale_options(): array {
		return [
			"ja-JP" => "Japanese (Japan)",
			"ja-OS" => "Japanese (Osaka)",
			"en-US" => "English (United States)",
			"en-GB" => "English (United Kingdom)",
			"zh-CN" => "Chinese (Simplified, China)",
			"zh-TW" => "Chinese (Traditional, Taiwan)",
		];
	}

	private static function load_language_messages(string $language): array {
		$path = self::JSON_DIR . "/lang_" . strtolower($language) . ".json";
		return self::load_json_file($path);
	}

	private static function load_json_file(string $path): array {
		if (isset(self::$cache[$path])) {
			return self::$cache[$path];
		}
		if (!is_file($path)) {
			self::$cache[$path] = [];
			return self::$cache[$path];
		}
		$json = file_get_contents($path);
		if ($json === false || trim($json) === "") {
			self::$cache[$path] = [];
			return self::$cache[$path];
		}
		$data = json_decode($json, true);
		if (!is_array($data)) {
			self::$cache[$path] = [];
			return self::$cache[$path];
		}
		self::$cache[$path] = $data;
		return self::$cache[$path];
	}
}
