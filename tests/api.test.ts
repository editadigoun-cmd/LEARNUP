import {afterEach,describe,it,expect,vi} from "vitest";
import {api} from "../src/api";
afterEach(()=>vi.unstubAllGlobals());
describe("typed API client",()=>{
 it("sends same-origin session credentials for authenticated requests",async()=>{
  const fetchMock=vi.fn().mockResolvedValue(new Response(JSON.stringify({user:{id:"u1",email:"a@b.com",display_name:"Alex"}}),{status:200,headers:{"Content-Type":"application/json"}}));
  vi.stubGlobal("fetch",fetchMock);await api.me();
  expect(fetchMock).toHaveBeenCalledWith("/api/me",expect.objectContaining({credentials:"include"}));
 });
 it("returns parsed course data",async()=>{
  vi.stubGlobal("fetch",vi.fn().mockResolvedValue(new Response(JSON.stringify({courses:[{id:"c1",title:"Bio"}]}),{status:200})));
  expect(await api.courses()).toEqual({courses:[{id:"c1",title:"Bio"}]});
 });
 it("surfaces API validation errors to the caller",async()=>{
  vi.stubGlobal("fetch",vi.fn().mockResolvedValue(new Response(JSON.stringify({error:{message:"Titre invalide"}}),{status:400})));
  await expect(api.createCourse({title:""})).rejects.toThrow("Titre invalide");
 });
 it("uploads documents as multipart without forcing JSON content type",async()=>{
  const fetchMock=vi.fn().mockResolvedValue(new Response(JSON.stringify({document:{id:"d1",status:"queued",original_name:"cours.pdf"}}),{status:202}));
  vi.stubGlobal("fetch",fetchMock);const file=new File(["pdf"],"cours.pdf",{type:"application/pdf"});
  const result=await api.uploadDocument("c1",file);expect(result.document.status).toBe("queued");
  const options=fetchMock.mock.calls[0][1] as RequestInit;expect(options.body).toBeInstanceOf(FormData);expect(new Headers(options.headers).has("Content-Type")).toBe(false);
 });
 it("requests due review cards with a course filter",async()=>{
  const fetchMock=vi.fn().mockResolvedValue(new Response(JSON.stringify({cards:[]}),{status:200}));
  vi.stubGlobal("fetch",fetchMock);await api.dueFlashcards(12,"course 1");
  expect(fetchMock).toHaveBeenCalledWith("/api/flashcards/due?limit=12&courseId=course%201",expect.objectContaining({credentials:"include"}));
 });
 it("submits a flashcard rating and receives next review interval",async()=>{
  const fetchMock=vi.fn().mockResolvedValue(new Response(JSON.stringify({review:{rating:3,nextDueAt:"2026-11-23T00:00:00.000Z",intervalDays:3,mastery:100}}),{status:200}));
  vi.stubGlobal("fetch",fetchMock);const result=await api.reviewFlashcard("card-1",3);
  expect(result.review.intervalDays).toBe(3);expect(fetchMock).toHaveBeenCalledWith("/api/flashcards/card-1/review",expect.objectContaining({method:"POST"}));
 });
 it("requests course-scoped quiz generation with chosen difficulty",async()=>{const fetchMock=vi.fn().mockResolvedValue(new Response(JSON.stringify({quiz:{id:"quiz-1",title:"Quiz",difficulty:"hard",questionCount:5}}),{status:201}));vi.stubGlobal("fetch",fetchMock);const result=await api.generateQuiz("course-1",5,"hard","chapter-1");expect(result.quiz.questionCount).toBe(5);expect(fetchMock).toHaveBeenCalledWith("/api/quizzes/generate",expect.objectContaining({method:"POST"}));});
 it("starts an attempt, submits an answer and completes it",async()=>{const fetchMock=vi.fn().mockResolvedValueOnce(new Response(JSON.stringify({attempt:{id:"attempt-1",totalCount:1}}),{status:201})).mockResolvedValueOnce(new Response(JSON.stringify({correct:true,correctAnswer:"B",explanation:"Because.",sourceRef:"Chapter"}),{status:200})).mockResolvedValueOnce(new Response(JSON.stringify({result:{score:100,correct:1,total:1,answered:1}}),{status:200}));vi.stubGlobal("fetch",fetchMock);const attempt=await api.startAttempt("quiz-1");const answer=await api.answerAttempt(attempt.attempt.id,"question-1","B");const result=await api.completeAttempt(attempt.attempt.id);expect(answer.correct).toBe(true);expect(result.result.score).toBe(100);expect(fetchMock).toHaveBeenCalledTimes(3);});
});