import pygame

pygame.init()
FPS = 60

def draw_menu(window: pygame.Surface):
    BUTTON_WIDTH = 200
    BUTTON_HEIGHT = 50
    CURRENT_WIDTH, CURRENT_HEIGHT = pygame.display.get_surface().get_size()
    BUTTON_POS_X = CURRENT_WIDTH / 2 - BUTTON_WIDTH / 2
    BUTTON_POS_Y = CURRENT_HEIGHT / 4 - BUTTON_HEIGHT / 2

    button1 = pygame.Rect(BUTTON_POS_X, BUTTON_POS_Y, BUTTON_WIDTH, BUTTON_HEIGHT)
    button2 = pygame.Rect(BUTTON_POS_X, BUTTON_POS_Y + 2 * BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)
    button3 = pygame.Rect(BUTTON_POS_X, BUTTON_POS_Y + 4 * BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)

    FONT = pygame.font.SysFont('Comic Sans MS', 35)

    pygame.draw.rect(window, (255, 0, 0), button1)
    pygame.draw.rect(window, (255, 0, 0), button2)
    pygame.draw.rect(window, (255, 0, 0), button3)

    playButtonText = FONT.render('PLAY', True, (255, 255, 255))
    optionsButtonText = FONT.render('OPTIONS', True, (255, 255, 255))
    quitButtonText = FONT.render('QUIT', True, (255, 255, 255))

    window.blit(playButtonText, playButtonText.get_rect(center=(BUTTON_POS_X + BUTTON_WIDTH/2, BUTTON_POS_Y + BUTTON_HEIGHT/2)))
    window.blit(optionsButtonText, optionsButtonText.get_rect(center=(BUTTON_POS_X + BUTTON_WIDTH/2, 2*BUTTON_HEIGHT + BUTTON_POS_Y + BUTTON_HEIGHT/2)))
    window.blit(quitButtonText, quitButtonText.get_rect(center=(BUTTON_POS_X + BUTTON_WIDTH/2, 4*BUTTON_HEIGHT + BUTTON_POS_Y + BUTTON_HEIGHT/2)))
    pygame.display.update()

def main():
    window = pygame.display.set_mode((800, 600), pygame.RESIZABLE)
    run = True
    clock = pygame.time.Clock()
    
    draw_menu(window)

    while run:
        clock.tick(FPS)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False
            if event.type == pygame.VIDEORESIZE:
                window = pygame.display.set_mode((event.w, event.h), pygame.RESIZABLE)
                draw_menu(window)
                pygame.display.update()
        keys_pressed = pygame.key.get_pressed()
            
    pygame.quit()


main()