import worker from "../../backend/src/index";
export const onRequest=({request,env,context})=>worker.fetch(request,env,context);
