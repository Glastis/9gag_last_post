SRC=			./main.c \

OBJ=			 $(SRC:.c=.o)

NAME=			 a.out

CFLAGS=			-Wall -Wextra -Werror -ansi -pedantic

all:			$(NAME)

$(NAME):		$(OBJ)
	gcc -o $(NAME) $(OBJ)

clean:
	rm -f $(OBJ)

fclean:			clean
	rm -f $(NAME)

re:			fclean all

.PHONY:	all clean fclean re
