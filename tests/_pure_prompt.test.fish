source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_prompt.fish
source $current_dirname/../functions/_pure_prompt_jobs.fish
source $current_dirname/../functions/_pure_prompt_virtualenv.fish
source $current_dirname/../functions/_pure_prompt_vimode.fish
source $current_dirname/../functions/_pure_prompt_symbol.fish
source $current_dirname/../functions/_pure_set_color.fish
source $current_dirname/../functions/_pure_get_prompt_symbol.fish
source $current_dirname/../functions/_pure_print_prompt.fish
source $current_dirname/../functions/_pure_string_width.fish
source $current_dirname/../functions/_pure_prompt_system_time.fish
source $current_dirname/../functions/_pure_prefix_root_prompt.fish
@mesg (print_filename $current_filename)


function setup
    purge_configs
    disable_colors
    set --global pure_symbol_prompt '>'  # using default ❯ break following tests
end

function teardown
    functions --erase id
end


@test "_pure_prompt: print prompt after succeeding command" (
    set --global pure_color_prompt_on_success magenta

    _pure_prompt $SUCCESS
) = (set_color magenta)'>'

@test "_pure_prompt: print prompt after failing command" (
    set --global pure_color_prompt_on_error red

    _pure_prompt $FAILURE
) = (set_color red)'>'

@test "_pure_prompt: print root prefix" (
    set --global pure_show_prefix_root_prompt true
    set --global pure_symbol_prefix_root_prompt '#'
    function id; echo 'root'; end # mock

    _pure_prompt $SUCCESS
) = "# >"

@test "_pure_prompt: no space before symbol in 2-lines prompt" (
    set --global pure_enable_single_line_prompt false

    _pure_prompt $SUCCESS
) = '>'

@test "_pure_prompt: space before symbol in 1-line prompt" (
    set --global pure_enable_single_line_prompt true

    _pure_prompt $SUCCESS
) = ' >'
