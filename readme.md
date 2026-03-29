# ZSH perf

## oh-myzsh

    - zsh-auto-suggestion
    - zsh-interactive-cd
    - fzf
    - nvm
    - zsh-syntax-highlighting


```bash
num  calls                time                       self            name
-----------------------------------------------------------------------------------
 1)    1        1083.81  1083.81   49.48%   1081.68  1081.68   49.39%  nvm_die_on_prefix
 2)    1        1839.71  1839.71   84.00%    420.00   420.00   19.18%  nvm_auto
 3)    2        1419.70   709.85   64.82%    244.91   122.46   11.18%  nvm
 4)   26        2067.72    79.53   94.41%    122.57     4.71    5.60%  _omz_source
 5)    1          89.84    89.84    4.10%     80.83    80.83    3.69%  nvm_ensure_version_installed
 6)    2          74.77    37.38    3.41%     74.77    37.38    3.41%  compaudit
 7)    1          57.42    57.42    2.62%     57.19    57.19    2.61%  fzf_setup_using_fzf
 8)    1          89.88    89.88    4.10%     15.11    15.11    0.69%  compinit

...
```   

**Shell init time: 2342 ms**

---- 

## Zsh only

Shell init time: 38 ms (first start) 32ms (second start)

----

Zsh

- env
- theme minimal
- history + compinit compdump
- aliases 

```bash
num  calls                time                       self            name
-----------------------------------------------------------------------------------
 1)    1          18.83    18.83   97.99%     18.83    18.83   97.99%  compinit
 2)    2           0.39     0.19    2.01%      0.39     0.19    2.01%  zsource

-----------------------------------------------------------------------------------

 1)    1          18.83    18.83   97.99%     18.83    18.83   97.99%  compinit

-----------------------------------------------------------------------------------

 2)    2           0.39     0.19    2.01%      0.39     0.19    2.01%  zsource
````

**Shell init time: 58 ms**


----


## ZSH + fzf,auto-completion + theme spaceship

```bash
num  calls                time                       self            name
-----------------------------------------------------------------------------------
 1)    3         107.30    35.77   81.59%     30.12    10.04   22.90%  zsource
 2)    1          48.79    48.79   37.10%     27.22    27.22   20.70%  spaceship::core::load_sections
 3)    1          24.21    24.21   18.41%     24.21    24.21   18.41%  compinit
 4)   84          23.94     0.29   18.21%     18.41     0.22   14.00%  spaceship::precompile
 5)    1           5.71     5.71    4.34%      5.71     5.71    4.34%  _zsh_highlight_bind_widgets
 6)   85           5.68     0.07    4.32%      5.68     0.07    4.32%  spaceship::exists
 7)    1          54.46    54.46   41.41%      4.50     4.50    3.42%  prompt_spaceship_setup
 8)   63           3.75     0.06    2.85%      3.75     0.06    2.85%  spaceship::defined
 9)   63           5.22     0.08    3.97%      3.12     0.05    2.38%  spaceship::is_section_async
10)    1           2.96     2.96    2.25%      2.96     2.96    2.25%  async_init
11)   63           2.10     0.03    1.59%      2.10     0.03    1.59%  spaceship::includes
12)    1           4.16     4.16    3.17%      1.04     1.04    0.79%  spaceship::worker::load
13)    5           0.81     0.16    0.62%      0.81     0.16    0.62%  add-zsh-hook
14)    2           0.71     0.36    0.54%      0.71     0.36    0.54%  is-at-least
15)   15           0.67     0.04    0.51%      0.67     0.04    0.51%  spaceship::deprecated
16)    2           0.34     0.17    0.26%      0.34     0.17    0.26%  (anon)
17)    1           0.13     0.13    0.10%      0.13     0.13    0.10%  -fast-highlight-fill-option-variables
18)    1           3.00     3.00    2.28%      0.04     0.04    0.03%  async
```   

**Shell init time: 227 ms**

----

## ZSH (fzf,) theme typewriter

```bash
num  calls                time                       self            name
-----------------------------------------------------------------------------------
 1)    1          52.87    52.87   38.31%     42.18    42.18   30.57%  tw_async_init_tasks
 2)    1          25.42    25.42   18.42%     25.42    25.42   18.42%  compinit
 3)    2          32.85    16.43   23.81%     24.44    12.22   17.71%  zsource
 4)    1          72.40    72.40   52.47%     11.06    11.06    8.02%  prompt_typewritten_setup
 5)    1           9.12     9.12    6.61%      9.12     9.12    6.61%  tw_redraw
 6)    1           7.46     7.46    5.41%      7.46     7.46    5.41%  _zsh_highlight_bind_widgets
 7)    2           4.54     2.27    3.29%      4.54     2.27    3.29%  async_init
 8)    2           4.07     2.03    2.95%      4.07     2.03    2.95%  promptinit
 9)    1           3.29     3.29    2.38%      2.78     2.78    2.01%  async_start_worker
10)    1          75.66    75.66   54.83%      2.41     2.41    1.75%  prompt
11)   10           1.18     0.12    0.85%      1.18     0.12    0.85%  add-zsh-hook
12)    1           1.02     1.02    0.74%      0.80     0.80    0.58%  async_flush_jobs
13)    3           0.65     0.22    0.47%      0.65     0.22    0.47%  is-at-least
14)    4           0.49     0.12    0.36%      0.49     0.12    0.36%  _async_send_job
15)    2           0.44     0.22    0.32%      0.44     0.22    0.32%  (anon)
16)    1          73.25    73.25   53.08%      0.25     0.25    0.18%  set_prompt
17)    3           0.63     0.21    0.46%      0.23     0.08    0.17%  async_job
18)    1          56.76    56.76   41.13%      0.18     0.18    0.13%  tw_setup
19)    1           0.09     0.09    0.07%      0.09     0.09    0.07%  -fast-highlight-fill-option-variables
20)    1           0.07     0.07    0.05%      0.07     0.07    0.05%  async_register_callback
21)    1           0.14     0.14    0.10%      0.05     0.05    0.03%  async_worker_eval
22)    1           3.41     3.41    2.47%      0.05     0.05    0.03%  tw_async_init_worker
23)    1           4.55     4.55    3.30%      0.04     0.04    0.03%  async
```  

**Shell init time: 208 ms**

----

## zsh + plugins + agnoster.theme

```bash
num  calls                time                       self            name
-----------------------------------------------------------------------------------
 1)    3          84.93    28.31   75.26%     33.73    11.24   29.89%  zsource
 2)    1          27.91    27.91   24.74%     27.91    27.91   24.74%  compinit
 3)    1          39.37    39.37   34.89%     25.32    25.32   22.44%  prompt_agnoster_setup
 4)    3          14.25     4.75   12.63%     14.25     4.75   12.63%  add-zsh-hook
 5)    1           9.78     9.78    8.66%      9.78     9.78    8.66%  _zsh_highlight_bind_widgets
 6)    1           1.45     1.45    1.28%      1.45     1.45    1.28%  is-at-least
 7)    1           0.26     0.26    0.23%      0.26     0.26    0.23%  (anon) [/Users/macbook/Sites/bin/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh:460]
 8)    1           0.09     0.09    0.08%      0.09     0.09    0.08%  -fast-highlight-fill-option-variables
 9)    1           0.05     0.05    0.05%      0.05     0.05    0.05%  (anon) [/Users/macbook/Sites/bin/zsh/plugins/fast-syntax-highlighting/fast-highlight:35]
```

**Shell init time: 202 ms (first run) 108ms**




