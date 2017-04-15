#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pwd.h>
#include <string.h>

#define COLLAPSE_TILDE 1
#define MIN_LETTERS    2
#define DOTS           ">"

char *collapse_tilde(char *cwd)
{
  const char *home = getpwuid(getuid())->pw_dir;
  // WARN: strlen. Fails when $HOME is ""
  int len = strlen(home);
  if (strncmp(home, cwd, len) == 0) {
    cwd[len-1] = '~';
    return cwd + len - 1;
  }
  return cwd;
}

int find_offset(char *dir) 
{
  dir+=1; // for /
  if (dir[0] == '.') return 1+MIN_LETTERS; // at most .XX
  else               return MIN_LETTERS; // at most XX 

}

char *shorten_segment(char *cwd) 
{
  // WARN: strstr
  char *n = strstr(cwd+1, "/"); // always will start with a /
  if (n == NULL) return NULL;   // no / found.

  int offset = find_offset(cwd);
  if (cwd+1+offset > n) {
    return n;
  }

  // WARN: memmove, strlen
  memmove(cwd+1+offset, n, strlen(n)+1);
  return cwd+1+offset;
}


char *shorten_path(int max, char *cwd_buf) {
  char *cwd = cwd_buf;

  if (COLLAPSE_TILDE) cwd = collapse_tilde(cwd);

  char *cwd_tmp = cwd;
  char *last_cwd = cwd;
  if (cwd_tmp[0] == '~') cwd_tmp+=1;
  // WARN: strlen 
  while (cwd_tmp != NULL && strlen(cwd) > max) {
    last_cwd = cwd_tmp;
    cwd_tmp = shorten_segment(cwd_tmp);
  }

  // WARN: strlen
  if (strlen(cwd) > max) cwd = last_cwd+1;
  
  return cwd;
}

int main(int argc, char *argv[]) 
{
  char cwd_buf[1024];

  if (argc < 2) {
    fprintf(stderr, "no max width specified.\n");
    return 1;
  }
  if (getcwd(cwd_buf, sizeof(cwd_buf)) == NULL) {
    fprintf(stderr, "getcwd() error.\n");
    return 1;
  }

  int maxwidth = atoi(argv[1]);
  if (maxwidth < 0) maxwidth = 0;

  //strcpy(cwd_buf, "/home/nick");
  char *p = shorten_path(maxwidth , cwd_buf);
  printf("%s\n", p);

  return 0;
}
