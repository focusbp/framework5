<?php

include_once(dirname(__FILE__) . "/../lib_ext/markdown/Parsedown.php");

class ParsedownStructured extends Parsedown
{
    public function parseToArray($text)
    {
        $this->DefinitionData = array();

        $text = str_replace(["\r\n", "\r"], "\n", $text);
        $text = trim($text, "\n");
        $lines = explode("\n", $text);

        $this->parsedElements = [];
        parent::lines($lines);  // reuse the existing lines logic

        return $this->parsedElements;
    }

    protected $parsedElements = [];

    protected function element(array $Element)
    {
        $type = $Element['name'];
        $content = isset($Element['text']) ? $Element['text'] : '';

        switch ($type) {
            case 'p':
                $this->parsedElements[] = ['type' => 'paragraph', 'text' => $this->flatten($content)];
                break;
            case 'h1': case 'h2': case 'h3': case 'h4': case 'h5': case 'h6':
                $this->parsedElements[] = [
                    'type' => 'heading',
                    'level' => (int) substr($type, 1),
                    'text' => $this->flatten($content)
                ];
                break;
            case 'ul': case 'ol':
                $items = [];
                foreach ($Element['text'] as $li) {
                    $items[] = is_array($li['text']) ? $this->flatten($li['text']) : $li['text'];
                }
                $this->parsedElements[] = [
                    'type' => 'list',
                    'ordered' => $type === 'ol',
                    'items' => $items
                ];
                break;
            case 'blockquote':
                $this->parsedElements[] = [
                    'type' => 'blockquote',
                    'text' => is_array($content) ? implode("\n", $content) : $content
                ];
                break;
            case 'code':
                $this->parsedElements[] = [
                    'type' => 'inline_code',
                    'text' => $content
                ];
                break;
            case 'pre':
                if (is_array($content) && isset($content['name']) && $content['name'] === 'code') {
                    $this->parsedElements[] = [
                        'type' => 'code_block',
                        'text' => $content['text'],
                        'language' => isset($content['attributes']['class']) ? str_replace('language-', '', $content['attributes']['class']) : null
                    ];
                }
                break;
            case 'hr':
                $this->parsedElements[] = ['type' => 'horizontal_rule'];
                break;
            case 'table':
                $table = ['type' => 'table', 'header' => [], 'rows' => []];
                $thead = $Element['text'][0]['text'][0]['text'];
                foreach ($thead as $cell) {
                    $table['header'][] = $this->flatten($cell['text']);
                }
                foreach ($Element['text'][1]['text'] as $row) {
                    $rowData = [];
                    foreach ($row['text'] as $cell) {
                        $rowData[] = $this->flatten($cell['text']);
                    }
                    $table['rows'][] = $rowData;
                }
                $this->parsedElements[] = $table;
                break;
            default:
                // fallback to original behavior for anything unhandled
                return parent::element($Element);
        }

        return ''; // no HTML output
    }

    private function flatten($text)
    {
        if (is_array($text)) {
            return implode("", array_map(function($t) {
                return is_array($t) ? $this->flatten($t) : $t;
            }, $text));
        }
        return $text;
    }
}
