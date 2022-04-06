import handler
import fcm_handler

def main():
    hr = handler.Handler()
    fcm = fcm_handler.Fcm()

    hr.populate_list_of_users()
    hr.populate_list_of_births()
    hr.store_births()
    fcm.send_to_token(hr.tokens, hr.messages)
    

if __name__ == "__main__":
    main()