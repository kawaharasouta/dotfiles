# vim cheetsheet


## basic operation

### move
- '[num]gg'	: move to [num]th line
- 'G'				: move to end
- '^'				: move to line head
- '$'				: move to line end0
- 'w'				: move word head
- 'e'				: move word end

### start insert mode
- 'i'				: 
- 'I'				:
- 'a'				:
- 'A'				:
- 'o'				:
- 'O'				:

- 's'				: delete char (where you are) and start insert mode
- 'S'				: delete line (where you are) and start insert mode

### related search
**search move**
- 'n'				: forward direction
- 'N'				: backward direction

**1line 1char**
- 'f'				: 1line 1char forward
- 'F'				: 1line 1char backward
- ';'				: re 'f'
- ','				: re 'F'

**brackets move**
- '%'				" move to pair brachet

### move tab
- '<tab>h'	: move tab left
- '<tab>l'	: move tab right


## related plugin 

### NEADTree
- '<C-e>'		: on/off
- 't'				: open file new tab


### denite


## Convenient (redo undo) operations

|	want to do	|	operation	|	redo	|	undo	|

| edit	|	{edit}	|	.	|	u	| 
| search 1line 1char forward	|	f{char}	|	;	|	,	| 
| search 1line 1char backword	|	F{char}	|	;	|	,	| 
|	search in document forward	|	/pattern<CR>	|	n	|	N	|
|	search in document forward	|	?pattern<CR>	|	n	|	N	|
|	replacement	|	:s/target/replacement	|	&	|	u	|
| qx no nannka makuro no yatu |

## オペレーターとモーションの組み合わせ

実践vim p51あたり

## 便利な使い方メモ
-	置換したいが，同音意義的なものが存在して一つ一つに対して置換をして良いかを判定しながら実行したい場合，
	検索と n による繰り返し検索と cw を使って編集をしたものを . で繰り返す．ことをすると非常に便利にできる．
- 上記の例と似たような形で，移動と編集を「移動の繰り返しキー」＋「編集の繰り返しキー(ほとんど場合 . )」を組み合わせて使うことによって
	上手に同じ編集を瞬時に複数回行うことができる． 
	- f での検索の繰り返し「;」と，「.」
	- 最後尾移動編集の「A」とその繰り返し「.」と，適当な行移動．
	
 
###### reference

- https://www.ne.jp/asahi/hishidama/home/tech/unix/vi.html
- 実践vim



