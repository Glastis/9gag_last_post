#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define BUFF_SIZE	1024

static char	*get_file(const char *path)
{
  int		i = 0;
  int		r = 0;
  int		fd = open(path, O_RDONLY);
  char		*str = malloc(BUFF_SIZE + 1);

  while ((r = read(fd, &str[i], BUFF_SIZE)) > 0)
    {
      i = r + i;
      str = realloc(str, i + BUFF_SIZE + 1);
    }
  str[i] = '\0';
  return (str);
}

static int	print_img_link(char *str)
{
  int		i = 0;

  while (str[i] && str[i] != '"')
    ++i;
  if (str[i - 4] == '.' && str[i - 3] == 'j' && str[i - 2] == 'p' && str[i - 1] == 'g')
    {
      i = 0;
      while (str[i] != '"' && str[i])
	{
	  printf("%c", str[i]);
	  ++i;
	}
      printf("\n");
      exit(0);
    }
  return (i);
}

static void	print_quotes(char *str)
{
  int		i = 0;

  while (str[i])
    {
      if (str[i] == '"')
	{
	  print_img_link(&str[i + 1]);
	  ++i;
	  while (str[i] != '"' && str[i])
	    ++i;
	}
      if (str[i])
	++i;
    }
}

int		main()
{
  print_quotes(get_file("index.html"));
  return (0);
}
