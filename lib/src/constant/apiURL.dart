
class APIURL{
  static const apiURL="https://api.dev.jarvis.cx";

  //Authentication
  static const getCurrentUser="$apiURL/api/v1/auth/me";
  static const signIn="$apiURL/api/v1/auth/sign-in";
  static const googleSignIn="$apiURL/api/v1/auth/google-sign-in";
  static const signUp="$apiURL/api/v1/auth/sign-up";
  static const signOut="$apiURL/api/v1/auth/sign-out";
  static const refreshToken="$apiURL/api/v1/auth/refresh";

  //AI chat
  static const doAIChat="$apiURL/api/v1/ai-chat";
  static const getConversations="$apiURL/api/v1/ai-chat/conversations";
  static getConversationHistory(String conversationId)=>"$apiURL/api/v1/ai-chat/conversations/$conversationId/messages";
  static const sendMessage="$apiURL/api/v1/ai-chat/messages";
  static const getUsage="$apiURL/api/v1/tokens/usage";


  //Prompt
  static const createPrompt="$apiURL/api/v1/prompts";
  static const getPrompt="$apiURL/api/v1/prompts";
  static updatePrompt(String id)=>"$apiURL/api/v1/prompts/$id";
  static deletePrompt(String id)=>"$apiURL/api/v1/prompts/$id";
  static addPromptToFavorite(String id)=>"$apiURL/api/v1/prompts/$id/favorite";
  static removePromptToFavorite(String id)=>"$apiURL/api/v1/prompts/$id/favorite";

}