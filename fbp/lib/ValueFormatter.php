<?php

class ValueFormatter {

	private $setting = [];

	function __construct(array $setting = []) {
		$this->setting = $setting;
	}

	function format_by_type(string $type, $value): string {
		if ($type === "date") {
			return $this->format_date($value);
		}
		if ($type === "datetime") {
			return $this->format_datetime($value);
		}
		if ($type === "year_month") {
			return $this->format_year_month($value);
		}
		if ($value === null) {
			return "";
		}
		if (is_scalar($value)) {
			return (string) $value;
		}
		return "";
	}

	function format_for_field(array $field, $value): string {
		$type = (string) ($field["type"] ?? "");
		$display_format = (int) ($field["display_format"] ?? 0);

		if ($display_format === 1) {
			return $this->format_currency($value);
		}
		if ($display_format === 2) {
			return $this->format_number($value, $type);
		}

		return $this->format_by_type($type, $value);
	}

	function format_date($value): string {
		return $this->format_timestamp_value($value, $this->get_setting_value("date_format", "Y/m/d"));
	}

	function format_datetime($value): string {
		return $this->format_timestamp_value($value, $this->get_setting_value("datetime_format", "Y/m/d H:i"));
	}

	function format_year_month($value): string {
		$value = (string) $value;
		if ($value === "") {
			return "";
		}

		$normalized = preg_replace('/[^0-9]/', '', $value);
		if (strlen($normalized) < 6) {
			return $value;
		}

		$year = substr($normalized, 0, 4);
		$month = substr($normalized, 4, 2);

		return strtr($this->get_setting_value("year_month_format", "Y/m"), [
			"Y" => $year,
			"m" => $month,
			"n" => (string) intval($month, 10),
		]);
	}

	function format_number($value, string $type = "float"): string {
		if ($value === null || $value === "") {
			return "";
		}
		if (!is_numeric($value)) {
			return (string) $value;
		}

		$decimals = $this->get_number_decimal_digits($type);
		return number_format(
			(float) $value,
			$decimals,
			$this->resolve_decimal_separator(),
			$this->resolve_thousands_separator()
		);
	}

	function format_currency($value): string {
		if ($value === null || $value === "") {
			return "";
		}
		if (!is_numeric($value)) {
			return (string) $value;
		}

		$currency_value = number_format(
			(float) $value,
			$this->get_currency_decimal_digits(),
			$this->resolve_decimal_separator(),
			$this->resolve_thousands_separator()
		);

		$symbol = $this->get_currency_symbol();
		if ($symbol === "") {
			return $currency_value;
		}

		if ($this->get_setting_value("currency_symbol_position", "before") === "after") {
			return $currency_value . " " . $symbol;
		}

		return $symbol . $currency_value;
	}

	private function format_timestamp_value($value, string $format): string {
		if ($value === null || $value === "") {
			return "";
		}
		if (!is_numeric($value)) {
			return (string) $value;
		}
		return date($format, (int) $value);
	}

	private function get_number_decimal_digits(string $type): int {
		if ($type === "number") {
			return 0;
		}
		return (int) $this->get_setting_value("number_decimal_digits", "2");
	}

	private function get_currency_decimal_digits(): int {
		$value = $this->get_setting_value("currency_decimal_digits", "");
		if ($value !== "") {
			return (int) $value;
		}
		if (in_array(strtoupper($this->get_setting_value("currency", "JPY")), ["JPY", "KRW", "VND"], true)) {
			return 0;
		}
		return 2;
	}

	private function get_currency_symbol(): string {
		$symbol = $this->get_setting_value("currency_symbol", "");
		if ($symbol !== "") {
			return $symbol;
		}

		$currency = strtoupper($this->get_setting_value("currency", "JPY"));
		$map = [
			"JPY" => "¥",
			"USD" => "$",
			"EUR" => "€",
			"GBP" => "£",
		];
		return $map[$currency] ?? $currency;
	}

	private function get_setting_value(string $key, string $default): string {
		if (isset($this->setting[$key]) && $this->setting[$key] !== "") {
			return (string) $this->setting[$key];
		}
		return $default;
	}

	private function resolve_decimal_separator(): string {
		$value = $this->get_setting_value("number_decimal_separator", "dot");
		if ($value === "," || $value === "comma") {
			return ",";
		}
		return ".";
	}

	private function resolve_thousands_separator(): string {
		$value = $this->get_setting_value("number_thousands_separator", "comma");
		if ($value === "." || $value === "dot") {
			return ".";
		}
		if ($value === " " || $value === "space") {
			return " ";
		}
		if ($value === "" || $value === "none") {
			return "";
		}
		return ",";
	}
}
